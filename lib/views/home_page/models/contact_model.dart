import 'dart:io';

class ContactModel {
  String? name, email, contact, dob;
  File? image;
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
  File? rImg;
  DateTime? rdate;
  RecentContactModel(
      {this.rName, this.remail, this.rContact, this.rImg, this.rdate});
}
