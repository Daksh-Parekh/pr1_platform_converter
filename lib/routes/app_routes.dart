import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/views/add_contact_page/views/add_contact_ios_page.dart';
import 'package:pr1_platform_converter/views/add_contact_page/views/add_contact_page.dart';
import 'package:pr1_platform_converter/views/bottom_navigation_page/views/bottom_navigator.dart';
import 'package:pr1_platform_converter/views/detail_page/views/detail_ios_page.dart';
import 'package:pr1_platform_converter/views/detail_page/views/detail_page.dart';
import 'package:pr1_platform_converter/views/favorite_page/views/favorite_page.dart';
import 'package:pr1_platform_converter/views/home_page/views/home_ios_page.dart';
import 'package:pr1_platform_converter/views/home_page/views/home_page.dart';
import 'package:pr1_platform_converter/views/recent_page/view/recent_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => BottomNavigator(),
    '/home_page': (context) => HomePage(),
    '/detail_Page': (context) => DetailPage(),
    '/add_contact_Page': (context) => AddContactPage(),
    '/recent_page': (context) => RecentPage(),
    '/favorite_page': (context) => FavoritePage(),
  };
  static Map<String, Widget Function(BuildContext)> iOSRoutes = {
    '/': (context) => HomeIosPage(),
    '/detail_iOS_Page': (context) => DetailIosPage(),
    '/add_contact_iOS_Page': (context) => AddContactIosPage(),
  };
}
