import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/main.dart';
import 'package:pr1_platform_converter/views/bottom_navigation_page/provider/bottom_provider.dart';
import 'package:pr1_platform_converter/views/favorite_page/views/favorite_page.dart';
import 'package:pr1_platform_converter/views/home_page/views/home_page.dart';
import 'package:pr1_platform_converter/views/recent_page/view/recent_page.dart';
import 'package:provider/provider.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  late BottomProvider bRead, bWatch;

  List<Widget> screens = [RecentPage(), HomePage(), FavoritePage()];
  @override
  Widget build(BuildContext context) {
    bRead = context.read<BottomProvider>();
    bWatch = context.watch<BottomProvider>();
    return Scaffold(
      body: screens[bWatch.selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: bWatch.selectedIndex,
        onDestinationSelected: (value) {
          bRead.changeIndex(value);
        },
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.restore_rounded), label: "Recent"),
          NavigationDestination(
              icon: Icon(Icons.people_alt_rounded), label: "Contact"),
          NavigationDestination(
              icon: Icon(Icons.star_border_rounded), label: "Favorite"),
        ],
      ),
    );
  }
}
