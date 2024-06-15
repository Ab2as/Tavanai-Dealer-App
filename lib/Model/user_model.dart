import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String profilePhoto;
  String email;
  String uid;
  String shopAddress;
  String state;
  String city;
  String pincode;

  User({
    required this.name,
    required this.email,
    required this.profilePhoto,
    required this.shopAddress,
    required this.state,
    required this.city,
    required this.pincode,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
        "state": state,
        "city": city,
        "shopAddress": shopAddress,
        "pincode": pincode,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      name: snapshot['name'],
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      shopAddress: snapshot['shopAddress'],
      state: snapshot['state'],
      city: snapshot['city'],
      pincode: snapshot['pincode'],
    );
  }
}
