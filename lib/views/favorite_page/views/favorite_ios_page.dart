import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FavouriteIosPage extends StatefulWidget {
  const FavouriteIosPage({super.key});

  @override
  State<FavouriteIosPage> createState() => _FavouriteIosPageState();
}

class _FavouriteIosPageState extends State<FavouriteIosPage> {
  late HomeProvider hRead, hWatch;
  @override
  Widget build(BuildContext context) {
    hRead = context.read<HomeProvider>();
    hWatch = context.watch<HomeProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Favourite Page"),
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Visibility(
              visible: hWatch.allContact[index].isFavorite == true,
              child: Divider());
        },
        itemCount: hWatch.allContact.length,
        itemBuilder: (context, index) {
          return Visibility(
            visible: hWatch.allContact[index].isFavorite == true,
            child: CupertinoListTile(
              leading: hWatch.allContact[index].image != null
                  ? CircleAvatar(
                      foregroundImage:
                          FileImage(File(hWatch.allContact[index].image!)),
                    )
                  : CircleAvatar(
                      child:
                          Text(hWatch.allContact[index].name!.substring(0, 1)),
                    ),
              title: Text(hWatch.allContact[index].name ?? ""),
              subtitle: Text("+91 ${hWatch.allContact[index].contact}"),
              trailing: IconButton(
                onPressed: () async {
                  await launchUrl(
                      Uri.parse('tel:${hWatch.allContact[index].contact}'));
                },
                icon: Icon(CupertinoIcons.phone),
              ),
              onTap: () {
                hRead.setIndex(index);
                Navigator.pushNamed(context, '/detail_iOS_Page',
                    arguments: hRead.allContact[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
