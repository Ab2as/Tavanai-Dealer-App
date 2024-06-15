import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanai_registration_app/Screen/AutomotiveScreen.dart';
import 'package:tavanai_registration_app/Screen/ERickshawScreen.dart';
import 'package:tavanai_registration_app/Screen/InverterScree.dart';
import 'package:tavanai_registration_app/Widget/containerCard.dart';

class BatteryScreen extends StatelessWidget {
  const BatteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.grey, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back),
                        iconSize: 30,
                        color: Colors.black,
                      ),
                      const Expanded(
                        child: Text(
                          'Tavanai Battery',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RectangleCard(
                      image: 'assets/images/automotive.jpg',
                      title: "Automotive",
                      subtitle:
                          "Passenger vehicle, power-trains, metros are becoming increasingly diverse as vehicle technology evolves to meet fuel-efficiency and carbon-emission regulations.",
                      onPressed: () {
                        Get.to(() => AutomotiveScreen());
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RectangleCard(
                      image: 'assets/images/inverter.jpg',
                      title: "Inverter",
                      subtitle:
                          "Tavanal batteries are high quality, maintenance-free batteries produced at a state of the art manufacturing facility with advanced battery manufacturing technologies and high-purity materials.",
                      onPressed: () {
                        Get.to(() => InverterScreen());
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RectangleCard(
                      image: 'assets/images/erickshaw.jpg',
                      title: "E-Rickshaw",
                      subtitle:
                          "Tavanai E-rickshaw Batteries are specially designed to ensure maximum milage.",
                      onPressed: () {
                        Get.to(() => ERickshawScreen());
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
