import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:pr1_platform_converter/views/recent_page/provider/recent_contact_provider.dart';
import 'package:provider/provider.dart';

class RecentIosPage extends StatefulWidget {
  const RecentIosPage({super.key});

  @override
  State<RecentIosPage> createState() => _RecentIosPageState();
}

class _RecentIosPageState extends State<RecentIosPage> {
  late RecentContactProvider rRead, rWatch;
  @override
  Widget build(BuildContext context) {
    rRead = context.read<RecentContactProvider>();
    rWatch = context.watch<RecentContactProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Recent Page"),
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: rWatch.recentContacts.length,
        itemBuilder: (context, index) {
          return CupertinoListTile(
            leading: rWatch.recentContacts[index].rImg != null
                ? CircleAvatar(
                    foregroundImage:
                        FileImage(File(rWatch.recentContacts[index].rImg!)),
                  )
                : CircleAvatar(
                    child: Text(
                        rWatch.recentContacts[index].rName!.substring(0, 1)),
                  ),
            title: Text(rWatch.recentContacts[index].rName ?? ""),
            subtitle: Text("+91 ${rWatch.recentContacts[index].rContact}"),
            trailing: Text(
              "${rWatch.recentContacts[index].rdate?.hour}:${rWatch.recentContacts[index].rdate?.minute}",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              // context.read<HomeProvider>().setIndex(index);
              Navigator.pushNamed(context, '/detail_Page',
                  arguments: rRead.recentContacts[index]);
            },
          );
        },
      ),
    );
  }
}
