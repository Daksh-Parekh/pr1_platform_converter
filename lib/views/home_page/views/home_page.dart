import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/utils/helper/shr_helper.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider hRead, hWatch;
  // @override
  // void initState() {
  //   ShrHelper shr = ShrHelper();
  //   shr.getTheme().then(
  //     (value) {
  //       log('$value');
  //       if (value == true) {
  //         log('${value}');
  //         hWatch.mode = ThemeMode.light;
  //       } else {
  //         hWatch.mode = ThemeMode.dark;
  //       }
  //     },
  //   );
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    hRead = context.read<HomeProvider>();
    hWatch = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          Switch(
            value: hWatch.isPlatform,
            onChanged: (value) {
              hRead.changePlatform();
            },
          ),
          IconButton.filledTonal(
            onPressed: () {
              hRead.changeTheme();
            },
            icon: hWatch.isThemeChange
                ? Icon(Icons.dark_mode_rounded)
                : Icon(Icons.light_mode_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: hWatch.allContact[index].image != null
                  ? CircleAvatar(
                      foregroundImage:
                          FileImage(hWatch.allContact[index].image!),
                    )
                  : CircleAvatar(
                      child: Text(
                          "${hWatch.allContact[index].name!.substring(0, 1)}"),
                    ),
              title: Text("${hWatch.allContact[index].name}"),
              subtitle: Text("+91 ${hWatch.allContact[index].contact}"),
              trailing: IconButton(
                onPressed: () {
                  hRead.deleteContact(index);
                },
                icon: Icon(Icons.delete_forever_rounded),
              ),
              onTap: () {
                context.read<HomeProvider>().setIndex(index);
                Navigator.pushNamed(context, '/detail_Page',
                    arguments: hRead.allContact[index]);
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: hWatch.allContact.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_contact_Page');
        },
        child: Text("Add"),
      ),
    );
  }
}
