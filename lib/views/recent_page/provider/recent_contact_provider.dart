import 'package:flutter/material.dart';
import 'package:pr1_platform_converter/views/home_page/models/contact_model.dart';

class RecentContactProvider with ChangeNotifier {
  List<RecentContactModel> recentContacts = [];

  void addRecentContact(RecentContactModel models) {
    recentContacts.add(models);
    notifyListeners();
  }
}
