import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/main.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:pr1_platform_converter/views/recent_page/provider/recent_contact_provider.dart';
import 'package:provider/provider.dart';

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  late RecentContactProvider rRead, rWatch;
  @override
  Widget build(BuildContext context) {
    rRead = context.read<RecentContactProvider>();
    rWatch = context.watch<RecentContactProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: rWatch.recentContacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: rWatch.recentContacts[index].rImg != null
                  ? CircleAvatar(
                      foregroundImage:
                          FileImage(File(rWatch.recentContacts[index].rImg!)),
                    )
                  : CircleAvatar(
                      child: Text(
                          "${rWatch.recentContacts[index].rName!.substring(0, 1).toUpperCase()}"),
                    ),
              title: Text("${rWatch.recentContacts[index].rName}"),
              subtitle: Text("+91 ${rWatch.recentContacts[index].rContact}"),
              trailing: Text(
                "${rWatch.recentContacts[index].rdate?.hour}:${rWatch.recentContacts[index].rdate?.minute}",
                style: TextStyle(fontSize: 20),
              ),
              // onTap: () {
              //   context.read<HomeProvider>().setIndex(index);
              //   Navigator.pushNamed(context, '/detail_Page',
              //       arguments: rRead.recentContacts[index]);
              // },
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
