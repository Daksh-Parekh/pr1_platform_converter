import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  Future<void> saveTheme(bool value) async {
    log('${value}shr');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', value);
  }

  Future<bool?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('theme') ?? true;
  }
}
