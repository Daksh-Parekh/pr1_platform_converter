import 'dart:developer';

import 'package:pr1_platform_converter/views/home_page/models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  Future<void> saveTheme(bool isdark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('themes', isdark);
  }

  Future<bool?> getThemes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('themes') ?? false;
  }

  Future<void> savePlatform(bool isPlatform) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPlatform', isPlatform);
    log('$isPlatform');
  }

  Future<bool?> getPlatform() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isPlatform') ?? true;
    // log('$isPlatforms');
    // return isPlatforms;
  }

  Future<void> saveContacts(String name, String number, String email) async {
    // log('${value}shr');
    log('saved before');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setStringList('contact', models as List<String>);
    // prefs.setString('');
    prefs.setString("name", name);
    prefs.setString("number", number);
    prefs.setString("email", email);
    log('saved');
  }

  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getBool('theme') ?? true;
    // return prefs.getStringList('contact');
    return prefs.getString('name');
  }

  Future<String?> getcontact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('number');
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
}
