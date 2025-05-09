import 'dart:developer';
import 'package:pr1_platform_converter/views/home_page/models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  Future<void> saveTheme(bool isdark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('themes', isdark);
  }

  Future<bool?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('themes');
  }

  Future<void> savePlatform(bool isPlatform) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPlatform', isPlatform);
    log('$isPlatform');
  }

  Future<bool?> getPlatform() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isPlatform');
  }

  Future<void> saveContacts(List<ContactModel> contacts) async {
    // log('${value}shr');
    log('saved before');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('contactIndex', contacts.length);
    // for (int i = 0; i < contacts.length; i++) {
    //   await prefs.setString('name$i', contacts[i].name!);
    //   await prefs.setString('mobileNo$i', contacts[i].contact!);
    //   await prefs.setString('email$i', contacts[i].email!);
    //   await prefs.setString('dob$i', contacts[i].dob!);
    //   await prefs.setString('img$i', contacts[i].image!);
    //   await prefs.setBool('isFav$i', contacts[i].isFavorite!);
    // }

    List<String> allContactData = contacts
        .map(
          (e) =>
              '${e.name},${e.email},${e.contact},${e.dob},${e.image},${e.isFavorite}',
        )
        .toList();
    await prefs.setStringList('allContacts', allContactData);
    log('saved');
  }

  Future<List<String>?> loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int? index=await prefs.getInt('contactIndex')??0;
    // for(int i=0;i<index!;i++){}
    return prefs.getStringList('allContacts');
  }

  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
