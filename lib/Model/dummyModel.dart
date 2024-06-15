import 'package:cloud_firestore/cloud_firestore.dart';

class MyModel {
  final String name;
  final String city;
  final String email;
  final String photo;
  final String state;
  final String pincode;
  final String shopAddress;
  final String uid;

  MyModel({
    required this.name,
    required this.city,
    required this.email,
    required this.photo,
    required this.state,
    required this.pincode,
    required this.shopAddress,
    required this.uid,
  });

  factory MyModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MyModel(
      name: data['name'] ?? '',
      city: data['city'] ?? '', // Assuming city is an integer
      email: data['email'] ?? '',
      state: data['state'] ?? '',
      pincode: data['pincode'] ?? '',
      uid: data['uid'] ?? '',
      shopAddress: data['shopAddress'] ?? '',
      photo: data['profilePhoto'] ??
          'https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
    );
  }
}
