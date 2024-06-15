import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String serial;
  String battery;
  String model;
  String date;
  String name;
  String address;
  String pincode;
  String email;
  String dealerEmail;

  Client({
    required this.serial,
    required this.battery,
    required this.model,
    required this.date,
    required this.name,
    required this.address,
    required this.pincode,
    required this.email,
    required this.dealerEmail,
  });

  Map<String, dynamic> toJson() => {
        "serial": serial,
        "battery": battery,
        "model": model,
        "date": date,
        "name": name,
        "address": address,
        "pincode": pincode,
        "email": email,
        "dealerEmail": dealerEmail,
      };

  static Client fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Client(
        serial: snapshot['serial'],
        battery: snapshot['battery'],
        model: snapshot['model'],
        date: snapshot['date'],
        name: snapshot['name'],
        address: snapshot['address'],
        pincode: snapshot['pincode'],
        email: snapshot['email'],
        dealerEmail: snapshot['dealerEmail']);
  }
}
