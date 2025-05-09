import 'package:flutter/cupertino.dart';
import 'package:pr1_platform_converter/routes/app_routes.dart';
import 'package:pr1_platform_converter/views/add_contact_page/views/add_contact_ios_page.dart';
import 'package:pr1_platform_converter/views/favorite_page/views/favorite_ios_page.dart';
import 'package:pr1_platform_converter/views/home_page/views/home_ios_page.dart';
import 'package:pr1_platform_converter/views/recent_page/view/recent_ios_page.dart';

class TabBarIos extends StatefulWidget {
  const TabBarIos({super.key});

  @override
  State<TabBarIos> createState() => _TabBarIosState();
}

class _TabBarIosState extends State<TabBarIos> {
  List screens = [
    RecentIosPage(),
    HomeIosPage(),
    FavouriteIosPage(),
    AddContactIosPage()
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.restart),
            label: "Recent",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2_fill),
            label: "Contact",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.star),
            label: "Favourite",
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          routes: AppRoutes.iOSRoutes,
          builder: (context) {
            return screens[index];
          },
        );
      },
    );
  }
}
