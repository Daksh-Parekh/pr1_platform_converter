import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/routes/app_routes.dart';
import 'package:pr1_platform_converter/views/add_contact_page/provider/add_contact_provider.dart';
import 'package:pr1_platform_converter/views/bottom_navigation_page/provider/bottom_provider.dart';
import 'package:pr1_platform_converter/views/home_page/provider/home_provider.dart';
import 'package:pr1_platform_converter/views/recent_page/provider/recent_contact_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AddContactProvider(),
        ),
        ChangeNotifierProvider.value(
          value: BottomProvider(),
        ),
        ChangeNotifierProvider.value(
          value: RecentContactProvider(),
        )
      ],
      child: Consumer<HomeProvider>(
        builder: (context, value, child) {
          return value.isPlatform
              ? MaterialApp(
                  themeMode: value.mode,
                  darkTheme: ThemeData(brightness: Brightness.dark),
                  routes: AppRoutes.routes,
                )
              : CupertinoApp(
                  theme: CupertinoThemeData(
                    brightness: value.brightness,
                  ),
                  routes: AppRoutes.iOSRoutes,
                );
        },
      ),
    );
  }
}
