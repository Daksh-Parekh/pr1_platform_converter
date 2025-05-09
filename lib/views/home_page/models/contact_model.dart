import 'dart:io';

class ContactModel {
  String? name, email, contact, dob;
  String? image;
  bool? isFavorite = false;
  ContactModel(
      {this.name,
      this.email,
      this.contact,
      this.dob,
      this.image,
      this.isFavorite});
}

class RecentContactModel {
  String? rName, rContact, remail;
  String? rImg;
  DateTime? rdate;
  RecentContactModel(
      {this.rName, this.remail, this.rContact, this.rImg, this.rdate});
}
