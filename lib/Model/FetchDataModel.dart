import 'package:cloud_firestore/cloud_firestore.dart';

class FetchItem {
  String city;
  String name;
  String email;
  String pincode;
  String profilePhoto;
  String shopAddress;
  String state;

  FetchItem(
      {required this.name,
      required this.shopAddress,
      required this.state,
      required this.city,
      required this.email,
      required this.pincode,
      required this.profilePhoto});

  factory FetchItem.fromDocument(DocumentSnapshot doc) {
    return FetchItem(
      name: doc['name'],
      email: doc['email'],
      state: doc['state'],
      city: doc['city'],
      pincode: doc['pincode'],
      profilePhoto: doc['profilePhoto'],
      shopAddress: doc['shopAddress'],
    );
  }
}
