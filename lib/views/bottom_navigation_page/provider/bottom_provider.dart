import 'package:flutter/material.dart';

class BottomProvider with ChangeNotifier {
  int selectedIndex = 1;
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
