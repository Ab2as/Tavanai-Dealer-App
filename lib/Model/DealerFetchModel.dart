import 'package:cloud_firestore/cloud_firestore.dart';

class MyModel1 {
  final String serial;
  final String battery;
  final String model;
  final String name;
  final String date;
  final String address;

  MyModel1({
    required this.serial,
    required this.battery,
    required this.model,
    required this.name,
    required this.date,
    required this.address,
  });

  factory MyModel1.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MyModel1(
      serial: data['serial'] ?? '',
      battery: data['battery'] ?? '',
      model: data['model'] ?? '',
      name: data['name'] ?? '',
      date: data['date'] ?? '',
      address: data['address'] ?? '',
    );
  }
}
