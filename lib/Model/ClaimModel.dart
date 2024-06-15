import 'package:cloud_firestore/cloud_firestore.dart';

class Claim {
  String serial;
  String battery;
  String model;
  String regisDate;
  String claimDate;
  String dealerName;
  String clientName;
  String shopAddress;
  String clientAddress;
  String completed;

  Claim({
    required this.serial,
    required this.battery,
    required this.model,
    required this.dealerName,
    required this.clientName,
    required this.regisDate,
    required this.claimDate,
    required this.shopAddress,
    required this.clientAddress,
    required this.completed,
  });

  Map<String, dynamic> toJson() => {
        "serial": serial,
        "battery": battery,
        "model": model,
        "dealerName": dealerName,
        "clientName": clientName,
        "regisDate": regisDate,
        "claimDate": claimDate,
        "shopAddress": shopAddress,
        "clientAddress": clientAddress,
        "completed": completed,
      };

  static Claim fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Claim(
      serial: snapshot['serial'],
      battery: snapshot['battery'],
      model: snapshot['model'],
      dealerName: snapshot['dealerName'],
      clientName: snapshot['clientName'],
      regisDate: snapshot['regisDate'],
      claimDate: snapshot['claimDate'],
      shopAddress: snapshot['shopAddress'],
      clientAddress: snapshot['clientAddress'],
      completed: snapshot['completed'],
    );
  }
}
