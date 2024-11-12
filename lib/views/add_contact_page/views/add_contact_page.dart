import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pr1_platform_converter/main.dart';
import 'package:pr1_platform_converter/utils/extension.dart';
import 'package:pr1_platform_converter/views/add_contact_page/provider/add_contact_provider.dart';
import 'package:pr1_platform_converter/views/home_page/models/contact_model.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:provider/provider.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late AddContactProvider addRead, addWatch;
  late HomeProvider homeRead;

  @override
  void dispose() {
    addRead.reset();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    addRead = context.read<AddContactProvider>();
    addWatch = context.watch<AddContactProvider>();
    homeRead = context.read<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contacts"),
      ),
      body: Stepper(
        currentStep: addWatch.setIndex,
        onStepContinue: () {
          addWatch.setIndex < 2
              ? addRead.changeIndex(addWatch.setIndex++)
              : null;
        },
        onStepCancel: () {
          addWatch.setIndex > 0
              ? addRead.changeIndex(addWatch.setIndex--)
              : null;
        },
        steps: [
          Step(
            title: Text("Photo"),
            content: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 80,
                  foregroundImage:
                      addWatch.img != null ? FileImage(addWatch.img!) : null,
                ),
                FloatingActionButton.small(
                  child: Icon(Icons.add),
                  onPressed: () async {
                    ImagePicker picker = ImagePicker();
                    XFile? img =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (img != null) {
                      addRead.setImage(File(img.path));
                      // addWatch.img = File(img.path);
                      log('Image Received');
                    } else {
                      log('Image not received');
                    }
                  },
                )
              ],
            ),
          ),
          Step(
            title: Text("Personal Info"),
            content: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: addWatch.nameController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return value!.isEmpty ? "Please Enter your name" : null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      hintText: "Enter Name",
                    ),
                  ),
                  10.h,
                  TextFormField(
                    controller: addWatch.contactController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    maxLength: 10,
                    validator: (value) {
                      return value!.isEmpty
                          ? "Please Enter your contact"
                          : value.length < 10
                              ? "Contact should be of 10 digits"
                              : null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Enter Mobile Number",
                    ),
                  ),
                  10.h,
                  TextFormField(
                    controller: addWatch.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return value!.isEmpty ? "Please Enter your Email" : null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_rounded),
                      hintText: "Enter your E-mail id",
                    ),
                  ),
                  10.h,
                  TextFormField(
                    controller: addWatch.dobController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1975),
                          lastDate: DateTime(2030));
                      addRead.changeDate(date!);
                    },
                    validator: (value) {
                      return value!.isEmpty
                          ? "Please Enter your Date of Birth"
                          : null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_month_rounded),
                      hintText: "Enter your Date of Birth",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: Text("Save"),
            content: ElevatedButton(
              onPressed: () {
                bool validate = formKey.currentState!.validate();
                if (validate) {
                  String name = addRead.nameController.text;
                  String email = addRead.emailController.text;
                  String contact = addRead.contactController.text;
                  String dob = addRead.dobController.text;
                  File? images =
                      addRead.img != null ? File(addRead.img!.path) : null;

                  ContactModel cm = ContactModel(
                      name: name,
                      email: email,
                      contact: contact,
                      dob: dob,
                      image: images);
                  homeRead.addContacts(cm);
                  Navigator.pop(context);
                }
              },
              child: Text("SAVE"),
            ),
          ),
        ],
      ),
    );
  }
}
