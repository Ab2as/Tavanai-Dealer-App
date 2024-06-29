import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanai_registration_app/Controller/ClientFetch.dart';
import 'package:tavanai_registration_app/Model/ClientFetchModel.dart';

class ClientInfoScreen extends StatelessWidget {
  ClientInfoScreen({super.key});
  final RegistrationController _controller = Get.put(RegistrationController());

  TextEditingController _searchController = TextEditingController();

  final FirebaseAuth auths = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    _controller.fetchAllModels();

    User? currentUser = auths.currentUser;
    String dealerEmail = currentUser?.email ?? '';

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 220, 215, 215),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.black,
              )),
          title: const Text(
            'Client Information',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 221, 216, 216),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            //   child: TextField(
            //     controller: _searchController,
            //     decoration: const InputDecoration(
            //       labelText: 'Search by Client Name',
            //       labelStyle: TextStyle(
            //           fontSize: 20,
            //           fontFamily: 'Roboto',
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black),
            //       prefixIcon: Icon(
            //         Icons.search,
            //         color: Colors.black,
            //         size: 30,
            //       ),
            //     ),
            //     onChanged: (value) {
            //       _controller.filterModels(value);
            //     },
            //   ),
            // ),
            Obx(
              () {
                if (_controller.regis.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  Registration? reg = _controller.regis.firstWhereOrNull(
                      (reg) => reg.dealerEmail == dealerEmail);

                  // Check if the model was found
                  if (reg == null) {
                    return const Center(
                        child:
                            Text('No data available for the current Battery'));
                  }
                  return Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: MediaQuery.of(context)
                          .size
                          .height, // Adjust the height as needed
                      child: ListView.builder(
                        itemCount: _controller.regis
                            .where((reg) => reg.dealerEmail == dealerEmail)
                            .length,

                        // _controller.filteredModels
                        //     .length, // Assuming only one data for now
                        itemBuilder: (context, index) {
                          Registration regi = _controller.filteredModels[index];

                          return CustomListTile(
                            dealerName: regi.name,
                            batteryType: regi.email,
                            onTap: () {
                              // Show dialog with Firebase data
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Client Data',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Client Name: ${regi.name}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Battery Serial: ${regi.serial}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Battery Type: ${regi.battery}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Battery Model: ${regi.model}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Purchase Date: ${regi.date}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Client Address: ${regi.address}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Pincode: ${regi.pincode}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Client Email: ${regi.email}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // Add more fields as needed
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String dealerName;
  final String batteryType;
  final VoidCallback onTap;

  const CustomListTile({
    required this.dealerName,
    required this.batteryType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: const Icon(Icons.battery_alert),
          title: Text(
            dealerName,
            style: const TextStyle(
              fontSize: 17,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(batteryType),
        ),
      ),
    );
  }
}
