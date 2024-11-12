import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/main.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:pr1_platform_converter/views/home_page/views/home_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late HomeProvider hRead, hWatch;
  @override
  Widget build(BuildContext context) {
    hRead = context.read<HomeProvider>();
    hWatch = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Visibility(
              visible: hWatch.allContact[index].isFavorite == true,
              child: ListTile(
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
                  onPressed: () async {
                    await launchUrl(
                        Uri.parse('tel:${hWatch.allContact[index].contact}'));
                  },
                  icon: Icon(Icons.call),
                ),
                onTap: () {
                  hRead.setIndex(index);
                  Navigator.pushNamed(context, '/detail_Page',
                      arguments: hRead.allContact[index]);
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: hWatch.allContact.length,
        ),
      ),
    );
  }
}
