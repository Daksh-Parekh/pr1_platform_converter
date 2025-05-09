import 'dart:io';

import 'package:flutter/material.dart';

class AddContactProvider with ChangeNotifier {
  int setIndex = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String? img;

  int segmentControl = 0;

  void changeIndex(int inx) {
    inx = setIndex;
    notifyListeners();
  }

  void setImage(String image) {
    img = image;
    notifyListeners();
  }

  void changeDate(DateTime d1) {
    String d = "${d1.day}/${d1.month}/${d1.year}";
    dobController.text = d;
    notifyListeners();
  }

  void reset() {
    nameController.clear();
    contactController.clear();
    emailController.clear();
    dobController.clear();
    img = null;
    setIndex = 0;
    segmentControl = 0;
    notifyListeners();
  }

  void changeSegmentControl(int inx) {
    segmentControl = inx;
    notifyListeners();
  }
}
