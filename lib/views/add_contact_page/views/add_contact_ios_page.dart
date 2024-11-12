import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pr1_platform_converter/main.dart';
import 'package:pr1_platform_converter/utils/extension.dart';
import 'package:pr1_platform_converter/views/add_contact_page/provider/add_contact_provider.dart';
import 'package:pr1_platform_converter/views/home_page/models/contact_model.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:pr1_platform_converter/views/home_page/views/home_page.dart';
import 'package:provider/provider.dart';

class AddContactIosPage extends StatefulWidget {
  const AddContactIosPage({super.key});

  @override
  State<AddContactIosPage> createState() => _AddContactIosPageState();
}

class _AddContactIosPageState extends State<AddContactIosPage> {
  // late HomeProvider hRead, hWatch;
  late AddContactProvider addRead, addWatch;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: CupertinoSlidingSegmentedControl(
          children: {
            0: Text("Photo"),
            1: Text("Personal"),
            2: Text("Save"),
          },
          onValueChanged: (value) {
            addRead.changeSegmentControl(value!);
          },
          groupValue: addWatch.segmentControl,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addWatch.segmentControl == 0
                ? Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        foregroundImage: addWatch.img != null
                            ? FileImage(addWatch.img!)
                            : null,
                      ),
                      FloatingActionButton.small(
                        onPressed: () async {
                          ImagePicker picker = ImagePicker();
                          XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            addRead.setImage(
                              File(image.path),
                            );
                          }
                        },
                        child: Icon(Icons.camera),
                      ),
                    ],
                  )
                : addWatch.segmentControl == 1
                    ? Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CupertinoTextFormFieldRow(
                              controller: addWatch.nameController,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Please Enter your name"
                                    : null;
                              },
                              placeholder: "Enter Name",
                              prefix: Icon(CupertinoIcons.person),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            10.h,
                            CupertinoTextFormFieldRow(
                              controller: addWatch.contactController,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Please Enter your Coontact"
                                    : value.length < 10
                                        ? "Contact should be of 10 digits"
                                        : null;
                              },
                              placeholder: "Enter Contact Number",
                              prefix: Icon(CupertinoIcons.phone),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            10.h,
                            CupertinoTextFormFieldRow(
                              controller: addWatch.emailController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Please Enter your Email Address"
                                    : null;
                              },
                              placeholder: "Enter Email Address",
                              prefix: Icon(CupertinoIcons.mail),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            10.h,
                            CupertinoTextFormFieldRow(
                              controller: addWatch.dobController,
                              readOnly: true,
                              onTap: () async {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 200,
                                      color: CupertinoColors.white,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (value) {
                                          addRead.changeDate(value);
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Please Select a date of Birth"
                                    : null;
                              },
                              placeholder: "Select Date of Birth",
                              prefix: Icon(CupertinoIcons.calendar),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      )
                    : CupertinoButton.filled(
                        child: Text("SAVE"),
                        onPressed: () {
                          // bool validate = formKey.currentState!.validate();
                          // if (validate) {
                          String name = addRead.nameController.text;
                          String email = addRead.emailController.text;
                          String contact = addRead.contactController.text;
                          String dob = addRead.dobController.text;
                          File? images = addRead.img != null
                              ? File(addRead.img!.path)
                              : null;

                          ContactModel cm = ContactModel(
                            name: name,
                            email: email,
                            contact: contact,
                            dob: dob,
                            image: images,
                          );
                          homeRead.addContacts(cm);
                          Navigator.pop(context);
                          // }
                        },
                      ),
            Text("${addWatch.segmentControl}"),
          ],
        ),
      ),
    );
  }
}
