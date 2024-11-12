import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/utils/helper/shr_helper.dart';
import 'package:pr1_platform_converter/views/home_page/models/contact_model.dart';

class HomeProvider with ChangeNotifier {
  bool isPlatform = true;
  List<ContactModel> allContact = [
    ContactModel(
        name: "dax",
        contact: "874124854",
        dob: "10/12/2005",
        email: "sdf",
        isFavorite: false),
  ];
  int index = 0;

  ThemeMode mode = ThemeMode.light;
  bool isThemeChange = true;
  Brightness brightness = Brightness.light;
  void changeIosTheme() {
    isThemeChange = !isThemeChange;
    brightness = isThemeChange ? Brightness.light : Brightness.dark;
    notifyListeners();
  }

  void changeTheme() {
    isThemeChange = !isThemeChange;
    mode = isThemeChange ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void changePlatform() {
    isPlatform = !isPlatform;
    notifyListeners();
  }

  void addContacts(ContactModel models) {
    allContact.add(models);
    notifyListeners();
  }

  void updateContacts(ContactModel modal) {
    allContact[index] = modal;
    notifyListeners();
  }

  void setIndex(int inx) {
    index = inx;
    notifyListeners();
  }

  void deleteContact(int inx) {
    allContact.removeAt(inx);
    notifyListeners();
  }

  void addFavoriteContact() {
    if (allContact[index].isFavorite == false) {
      allContact[index].isFavorite = true;
    } else {
      allContact[index].isFavorite = false;
    }
    notifyListeners();
  }
}
