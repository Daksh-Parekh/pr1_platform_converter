import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/utils/helper/shr_helper.dart';
import 'package:pr1_platform_converter/views/home_page/models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {
  bool isPlatform = true;
  List<ContactModel> allContact = [];
  int index = 0;

  // ThemeMode mode = ThemeMode.light;
  bool isThemeChange = true;

  void changeTheme() {
    isThemeChange = !isThemeChange;
    // mode = isThemeChange ? ThemeMode.light : ThemeMode.dark;
    ShrHelper helps = ShrHelper();
    helps.saveTheme(isThemeChange);
    notifyListeners();
  }

  void getThemes() async {
    ShrHelper hepls = ShrHelper();
    isThemeChange = await hepls.getTheme() ?? false;
    notifyListeners();
  }

  void changePlatform() {
    isPlatform = !isPlatform;
    ShrHelper helper = ShrHelper();
    helper.savePlatform(isPlatform);
    log('${isPlatform}hp');
    notifyListeners();
  }

  Future<void> getPlatform() async {
    ShrHelper helper = ShrHelper();
    isPlatform = await helper.getPlatform() ?? true;
    notifyListeners();
  }

  void addContacts(ContactModel models) {
    allContact.add(models);
    notifyListeners();
  }

  void updateContacts(ContactModel modal) {
    allContact[index] = modal;
    ShrHelper helper = ShrHelper();
    helper.saveContacts(allContact);
    notifyListeners();
  }

  void setIndex(int inx) {
    index = inx;
    notifyListeners();
  }

  void deleteContact(int inx) {
    allContact.removeAt(inx);
    ShrHelper shrHelper = ShrHelper();
    shrHelper.saveContacts(allContact);
    notifyListeners();
  }

  void addFavoriteContact() {
    log("****${allContact[index].isFavorite}");
    if (allContact[index].isFavorite == false) {
      allContact[index].isFavorite = true;
      log("//////////////${allContact[index].isFavorite}");
    } else {
      allContact[index].isFavorite = false;
    }
    log("//////////after////${allContact[index].isFavorite}");
    notifyListeners();
  }

  Future<void> getContactData() async {
    ShrHelper helper = ShrHelper();
    List<String>? data = await helper.loadContacts() ?? [];
    // for (int i = 0; i < data.length; i++) {}
    allContact = data.map(
      (e) {
        var splistItems = e.split(',');
        return ContactModel(
          name: splistItems[0],
          email: splistItems[1],
          contact: splistItems[2],
          dob: splistItems[3],
          image: splistItems[4],
          isFavorite: bool.parse(splistItems[5]),
        );
      },
    ).toList();
  }
  // Future<void> getProfileDetails() async {
  //   ShrHelper shr = ShrHelper();
  //   allContact[index].name = await shr.getName();
  //   allContact[index].email = await shr.getEmail();
  //   allContact[index].contact = await shr.getcontact();
  //   notifyListeners();
  // }
}
