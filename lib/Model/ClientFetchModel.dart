import 'package:cloud_firestore/cloud_firestore.dart';

class Registration {
  final String serial;
  final String battery;
  final String model;
  final String name;
  final String date;
  final String address;
  final String dealerEmail;
  final String email;
  final String pincode;

  Registration({
    required this.serial,
    required this.battery,
    required this.model,
    required this.name,
    required this.date,
    required this.address,
    required this.dealerEmail,
    required this.email,
    required this.pincode,
  });

  factory Registration.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Registration(
      serial: data['serial'] ?? '',
      battery: data['battery'] ?? '',
      model: data['model'] ?? '',
      name: data['name'] ?? '',
      date: data['date'] ?? '',
      address: data['address'] ?? '',
      dealerEmail: data['dealerEmail'] ?? '',
      email: data['email'] ?? '',
      pincode: data['pincode'] ?? '',
    );
  }
}
