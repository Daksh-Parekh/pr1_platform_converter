import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pr1_platform_converter/main.dart';
import 'package:pr1_platform_converter/utils/extension.dart';
import 'package:pr1_platform_converter/views/add_contact_page/provider/add_contact_provider.dart';
import 'package:pr1_platform_converter/views/home_page/models/contact_model.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:pr1_platform_converter/views/recent_page/provider/recent_contact_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  late HomeProvider hRead, hWatch;
  late RecentContactProvider rRead;
  @override
  Widget build(BuildContext context) {
    hRead = context.read<HomeProvider>();
    hWatch = context.watch<HomeProvider>();
    rRead = context.read<RecentContactProvider>();
    ContactModel model =
        ModalRoute.of(context)!.settings.arguments as ContactModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        actions: [
          IconButton.filledTonal(
            onPressed: () {
              nameController.text = model.name!;
              emailController.text = model.email!;
              contactController.text = model.contact!;
              dobController.text = model.dob!;
              editDialog(context);
            },
            icon: Icon(Icons.edit),
          ),
          IconButton.filledTonal(
            onPressed: () {
              hRead.addFavoriteContact();

              Navigator.pop(context);
            },
            icon: model.isFavorite ?? false
                ? const Icon(Icons.star)
                : Icon(Icons.star_border),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            model.image != null
                ? CircleAvatar(
                    radius: 70,
                    foregroundImage: FileImage(model.image!),
                  )
                : CircleAvatar(
                    radius: 70,
                    child: Text(
                      model.name!.substring(0, 1).toUpperCase(),
                      style: TextStyle(fontSize: 75),
                    ),
                  ),
            15.h,
            Text(model.name!),
            12.h,
            ListTile(
              leading: Icon(Icons.mail),
              title: Text(
                model.email!,
              ),
            ),
            ListTile(
              title: Text("+91 ${model.contact!}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.filledTonal(
                    onPressed: () async {
                      await launchUrl(Uri.parse('tel:${model.contact}'));

                      RecentContactModel rm = RecentContactModel(
                          rName: model.name,
                          rImg: model.image,
                          rContact: model.contact,
                          remail: model.email);
                      rRead.addRecentContact(rm);
                    },
                    icon: Icon(Icons.phone),
                  ),
                  IconButton.filledTonal(
                    onPressed: () async {
                      await launchUrl(Uri.parse('sms:${model.contact}'));
                    },
                    icon: Icon(Icons.message_rounded),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_rounded),
              title: Text(model.dob!),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> editDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Details..."),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
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
                  controller: contactController,
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
                  controller: emailController,
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
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("CANCEL"),
            ),
            ElevatedButton(
              onPressed: () {
                ContactModel model = ContactModel(
                    name: nameController.text,
                    email: emailController.text,
                    contact: contactController.text,
                    dob: dobController.text);
                context.read<HomeProvider>().updateContacts(model);
                Navigator.pop(context);
              },
              child: Text("SAVE"),
            ),
          ],
        );
      },
    );
  }
}
