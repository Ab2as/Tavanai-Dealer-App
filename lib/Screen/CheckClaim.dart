import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanai_registration_app/Controller/DealerFetch.dart';
import 'package:tavanai_registration_app/Controller/auth_controller.dart';
import 'package:tavanai_registration_app/Controller/dummyFetch.dart';
import 'package:tavanai_registration_app/Model/DealerFetchModel.dart';
import 'package:tavanai_registration_app/Model/dummyModel.dart';
import 'package:tavanai_registration_app/Screen/ClaimScreen.dart';
import 'package:tavanai_registration_app/Screen/HomeScreen.dart';

class DCheckclaim extends StatelessWidget {
  DCheckclaim({required this.serial, required this.date, super.key});

  final String serial;
  final String date;

  final MyModel1Controller controller = Get.put(MyModel1Controller());
  final MyModelController controllerD = Get.put(MyModelController());
  AuthController authController = Get.put(AuthController());
  final FirebaseAuth auths = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    controller.fetchAllModels();
    controllerD.fetchAllModels();
    User? currentUser = auths.currentUser;
    String dealerEmail = currentUser?.email ?? '';
    DateTime regDate = DateTime.parse(date); // Parse the string to DateTime
    DateTime newDate = regDate;
    String regisDate;
    DateTime registrationDate;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (controller.models.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            MyModel1? model1 = controller.models.firstWhereOrNull(
              (model1) => model1.serial == serial,
            );
            MyModel? modelD = controllerD.models.firstWhereOrNull(
              (modelD) => modelD.email == dealerEmail,
            );

            if (model1 == null) {
              return const Center(
                  child: Text('No data available for the current user email'));
            }

            regisDate = model1.date;
            registrationDate = DateTime.parse(regisDate);

            String serialNo = model1.serial;
            String battery = model1.battery;
            String model = model1.model;
            String registrationdate = model1.date;
            String clientname = model1.name;
            String clientaddress = model1.address;
            String dealername = modelD!.name;
            String shopaddress = modelD.shopAddress;
            String completed = "false";

            if (model1.model == "TIB-105 18-M" ||
                model1.model == "TIB-110 18-M" ||
                model1.model == "TIB-450 18-M" ||
                model1.model == "TIB-700 18-M" ||
                model1.model == "TIB-850 18-M" ||
                model1.model == "TIB-1500 18-M" ||
                model1.model == "TIT-180 18-M") {
              int daysToAdd = 548;
              newDate = registrationDate.add(Duration(days: daysToAdd));
            } else if (model1.model == "TIB-400 12-M" ||
                model1.model == "TIB-600 12-M" ||
                model1.model == "TIB-750 12-M" ||
                model1.model == "TIB-1350 12-M") {
              int daysToAdd = 365;
              newDate = registrationDate.add(Duration(days: daysToAdd));
            } else if (model1.model == "TIT-200 24-M" ||
                model1.model == "TIT-220 24-M" ||
                model1.model == "TIT-200 JUMBO 24-M" ||
                model1.model == "TIT-220 JUMBO 24-M") {
              int daysToAdd = 731;
              newDate = registrationDate.add(Duration(days: daysToAdd));
            } else if (model1.model == "TIT-250 36-M") {
              int daysToAdd = 1096;
              newDate = registrationDate.add(Duration(days: daysToAdd));
            } else if (model1.model == "TER-105 6-M" ||
                model1.model == "TER-120 6-M") {
              int daysToAdd = 183;
              newDate = registrationDate.add(Duration(days: daysToAdd));
            } else if (model1.model == "TIB-130 9-M" ||
                model1.model == "TIB-140 9-M") {
              int daysToAdd = 274;
              newDate = registrationDate.add(Duration(days: daysToAdd));
            }

            if (newDate.compareTo(regDate) == 0) {
              print("Both date time are at same moment.");
              return _buildSuccessDialog("Claimed", () async {
                bool isClaim = await authController.ClaimRegister(
                  serialNo,
                  battery,
                  model,
                  dealername,
                  clientname,
                  registrationdate,
                  date,
                  shopaddress,
                  clientaddress,
                  completed,
                );
                if (isClaim) {
                  Get.to(() => HomeScreen());
                } else {
                  Get.snackbar("Error", "Failed to update profile",
                      snackPosition: SnackPosition.BOTTOM);
                }
              });
            }

            if (newDate.compareTo(regDate) < 0) {
              print("DT1 is before DT2");
              return _buildSuccessDialog("Sorry! Passed the Claimed Date", () {
                Get.to(const ClaimScreen());
              });
            }

            if (newDate.compareTo(regDate) > 0) {
              print("DT1 is after DT2");
              return _buildSuccessDialog("Claimed", () {
                authController.ClaimRegister(
                  serialNo,
                  battery,
                  model,
                  dealername,
                  clientname,
                  registrationdate,
                  date,
                  shopaddress,
                  clientaddress,
                  completed,
                );
                Get.to(HomeScreen());
              });
            }

            return const Text("");
          }
        }),
      ),
    );
  }

  Widget _buildSuccessDialog(String message, VoidCallback page) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          message,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20.0),
        const Text(
          'Registration successful!',
          style: TextStyle(fontSize: 18.0, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: page,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
