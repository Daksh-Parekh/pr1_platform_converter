import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pr1_platform_converter/utils/extension.dart';
import 'package:pr1_platform_converter/views/add_contact_page/provider/add_contact_provider.dart';
import 'package:pr1_platform_converter/views/home_page/models/contact_model.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:pr1_platform_converter/views/recent_page/provider/recent_contact_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailIosPage extends StatefulWidget {
  const DetailIosPage({super.key});

  @override
  State<DetailIosPage> createState() => _DetailIosPageState();
}

class _DetailIosPageState extends State<DetailIosPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  late HomeProvider hRead;
  late RecentContactProvider rRead;
  @override
  Widget build(BuildContext context) {
    hRead = context.read<HomeProvider>();
    rRead = context.read<RecentContactProvider>();

    ContactModel model =
        ModalRoute.of(context)!.settings.arguments as ContactModel;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Detail Page"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                nameController.text = model.name!;
                emailController.text = model.email!;
                contactController.text = model.contact!;
                dobController.text = model.dob!;
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text("Update Details"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            CupertinoTextFormFieldRow(
                              controller: nameController,
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
                              controller: contactController,
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
                              controller: dobController,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Please Enter your dob"
                                    : null;
                              },
                              placeholder: "Enter DOB",
                              prefix: Icon(CupertinoIcons.person),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            10.h,
                          ],
                        ),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("CANCEL"),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            ContactModel model = ContactModel(
                              name: nameController.text,
                              email: emailController.text,
                              dob: dobController.text,
                            );
                            hRead.updateContacts(model);
                            Navigator.pop(context);
                          },
                          child: Text("SAVE"),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(CupertinoIcons.pen),
            ),
            IconButton(
              onPressed: () {
                hRead.addFavoriteContact();

                Navigator.pop(context);
              },
              icon: model.isFavorite ?? false
                  ? const Icon(CupertinoIcons.star_fill)
                  : Icon(CupertinoIcons.star),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
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
            20.h,
            Text(model.name!),
            12.h,
            CupertinoListTile(
              leading: Icon(CupertinoIcons.mail),
              title: Text(
                model.email!,
              ),
            ),
            CupertinoListTile(
              title: Text("+91 ${model.contact}"),
              trailing: Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: () async {
                      await launchUrl(Uri.parse('tel:${model.contact}'));

                      RecentContactModel rm = RecentContactModel(
                        rName: model.name,
                        rImg: model.image,
                        rContact: model.contact,
                        remail: model.email,
                        rdate: DateTime.now(),
                      );
                      rRead.addRecentContact(rm);
                    },
                    icon: Icon(CupertinoIcons.phone),
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
            CupertinoListTile(
              leading: Icon(CupertinoIcons.calendar),
              title: Text(
                model.dob!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
