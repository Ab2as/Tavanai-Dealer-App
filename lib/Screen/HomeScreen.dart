import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanai_registration_app/Controller/auth_controller.dart';
import 'package:tavanai_registration_app/Controller/dummyFetch.dart';
import 'package:tavanai_registration_app/Model/dummyModel.dart';
import 'package:tavanai_registration_app/Screen/BatteryScreen.dart';
import 'package:tavanai_registration_app/Screen/ClaimScreen.dart';
import 'package:tavanai_registration_app/Screen/ClientScreen.dart';
import 'package:tavanai_registration_app/Screen/RegistrationScreen.dart';
import 'package:tavanai_registration_app/Screen/profileScreen.dart';
import 'package:tavanai_registration_app/Widget/Card3D.dart';

class HomeScreen extends StatelessWidget {
  final AuthController auth = Get.put(AuthController());
  final MyModelController controller = Get.put(MyModelController());

  final FirebaseAuth auths = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    controller.fetchAllModels();

    User? currentUser = auths.currentUser;
    String dealerEmail = currentUser?.email ?? '';

    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (controller.models.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // MyModel? model = controller.getModelByEmail();
            MyModel? model = controller.models.firstWhereOrNull(
              (model) => model.email == dealerEmail,
            );

            // Check if the model was found
            if (model == null) {
              return const Center(
                  child: Text('No data available for the current user email'));
            }

            return Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey, Colors.white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(ProfileScreen());
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage('${model.photo}'),
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Tavanai',
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Welcome ",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'PlayFair'),
                                ),
                                Text(
                                  '${model.name}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'PlayFair'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "How we can help?",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PlayFair'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 240,
                          width: 190,
                          child: ThreeDCard(
                              imageUrl:
                                  'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                              text: "Battery",
                              onPressed: () {
                                Get.to(() => const BatteryScreen());
                              }),
                        ),
                        SizedBox(
                          height: 240,
                          width: 190,
                          child: ThreeDCard(
                              imageUrl:
                                  'https://thumbs.dreamstime.com/b/flat-design-ready-to-animation-characters-ready-to-animation-web-page-template-online-registration-form-office-work-131331696.jpg',
                              text: "Registration",
                              onPressed: () {
                                Get.to(() => const RegistrationScreen());
                              }),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 240,
                          width: 190,
                          child: ThreeDCard(
                              imageUrl:
                                  'https://img.freepik.com/free-vector/business-men-avatar-cartoon_24640-47583.jpg?w=740&t=st=1719650608~exp=1719651208~hmac=7aff059d1feef7151025eef3a8837930f4afce2a5f3be88133b11ea96904413c',
                              text: "Client Info",
                              onPressed: () {
                                Get.to(() => ClientInfoScreen());
                              }),
                        ),
                        SizedBox(
                          height: 240,
                          width: 190,
                          child: ThreeDCard(
                              imageUrl:
                                  'https://img.freepik.com/premium-vector/mortgage-process-concept-businesswoman-buying-property-with-mortgage-flat-vector-modern-illustration_566886-13468.jpg?w=900',
                              text: "Claim",
                              onPressed: () {
                                Get.to(const ClaimScreen());
                              }),
                        ),
                      ],
                    ),
                    // Center(
                    //   child: SizedBox(
                    //     height: 240,
                    //     width: 190,
                    //     child: ThreeDCard(
                    //         imageUrl:
                    //             'https://img.freepik.com/premium-vector/mortgage-process-concept-businesswoman-buying-property-with-mortgage-flat-vector-modern-illustration_566886-13468.jpg?w=900',
                    //         text: "Claim",
                    //         onPressed: () {
                    //           Get.to(const ClaimScreen());
                    //         }),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
