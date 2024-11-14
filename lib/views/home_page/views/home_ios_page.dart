import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/utils/extension.dart';
import 'package:pr1_platform_converter/utils/helper/shr_helper.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomeIosPage extends StatefulWidget {
  const HomeIosPage({super.key});

  @override
  State<HomeIosPage> createState() => _HomeIosPageState();
}

class _HomeIosPageState extends State<HomeIosPage> {
  late HomeProvider hRead, hWatch;
  @override
  Widget build(BuildContext context) {
    hRead = context.read<HomeProvider>();
    hWatch = context.watch<HomeProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Home Page"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoSwitch(
              value: hWatch.isPlatform,
              onChanged: (value) {
                hRead.changePlatform();

                ShrHelper helps = ShrHelper();
                helps.savePlatform(value);
              },
            ),
            IconButton(
              onPressed: () {
                hRead.changeIosTheme();
              },
              icon: hWatch.isThemeChange
                  ? Icon(CupertinoIcons.moon_stars_fill)
                  : Icon(CupertinoIcons.sun_max_fill),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return CupertinoListTile(
                    leading: hWatch.allContact[index].image != null
                        ? CircleAvatar(
                            foregroundImage:
                                FileImage(hWatch.allContact[index].image!),
                          )
                        : CircleAvatar(
                            child: Text(
                                hWatch.allContact[index].name!.substring(0, 1)),
                          ),
                    title: Text(hWatch.allContact[index].name ?? ""),
                    subtitle: Text("+91 ${hWatch.allContact[index].contact}"),
                    trailing: IconButton(
                        onPressed: () {
                          hRead.deleteContact(index);
                        },
                        icon: Icon(CupertinoIcons.delete)),
                    onTap: () {
                      hRead.setIndex(index);
                      Navigator.pushNamed(context, '/detail_iOS_Page',
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
            CupertinoButton.filled(
              onPressed: () {
                Navigator.pushNamed(context, '/add_contact_iOS_Page');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  5.w,
                  Text("Add Contact"),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
