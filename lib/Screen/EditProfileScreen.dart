import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tavanai_registration_app/Controller/auth_controller.dart';
import 'package:tavanai_registration_app/Controller/dummyFetch.dart';
import 'package:tavanai_registration_app/Model/dummyModel.dart';
import 'package:tavanai_registration_app/Screen/HomeScreen.dart';
import 'package:tavanai_registration_app/Widget/ElevatedButtonModel.dart';
import 'package:tavanai_registration_app/Widget/ImagePicker.dart';
import 'package:tavanai_registration_app/Widget/TextFieldModel.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen(
      {required this.name,
      required this.address,
      required this.city,
      required this.state,
      required this.pincode,
      Key? key})
      : super(key: key);

  String name;
  String address;
  String city;
  String state;
  String pincode;

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // string for displaying the error Message
  String? errorMessage;
  final AuthController auth = Get.put(AuthController());
  final MyModelController controller = Get.put(MyModelController());
  final String requiredEmail =
      'qwert@zxc.com'; // Replace with the required email
  String uidD = 'fgh';

  final FirebaseAuth auths = FirebaseAuth.instance;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController shopAddressEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController stateEditingController = TextEditingController();
  TextEditingController pincodeEditingController = TextEditingController();

  // AuthController authController = Get.put(AuthController());
  File? reimage;
  File? image;

  pickImage(ImageSource source) {
    AppImagePicker(source: source).pick(onPick: (File? img) {
      setState(() {
        this.image = img;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize the controller with existing data
    userNameEditingController = TextEditingController(text: widget.name);
    shopAddressEditingController = TextEditingController(text: widget.address);
    stateEditingController = TextEditingController(text: widget.state);
    cityEditingController = TextEditingController(text: widget.city);
    pincodeEditingController = TextEditingController(text: widget.pincode);
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    userNameEditingController.dispose();
    shopAddressEditingController.dispose();
    cityEditingController.dispose();
    stateEditingController.dispose();
    pincodeEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchAllModels();

    User? currentUser = auths.currentUser;
    String dealerEmail = currentUser?.email ?? '';

    Future<String?> getDocumentIdBySerial(String email) async {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('DealerProfile')
          .where('email', isEqualTo: dealerEmail)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      }
      return null;
    }
    //name,add,city,state,pin,photo

    return SafeArea(
      child: Scaffold(
        body: Obx(
          () {
            if (controller.models.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              MyModel? model = controller.models.firstWhereOrNull(
                (model) => model.email == dealerEmail,
              );

              if (model == null) {
                return const Center(
                    child:
                        Text('No data available for the current user email'));
              }
              uidD = model.uid;

              return Container(
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey, Colors.white],
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(Icons.arrow_back),
                                iconSize: 30.0,
                              )),

                          Stack(
                            children: [
                              image != null
                                  ? CircleAvatar(
                                      radius: 65,
                                      backgroundImage: FileImage(image!))
                                  : CircleAvatar(
                                      radius: 65,
                                      backgroundImage: NetworkImage(
                                          'https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'
                                          // '${model.photo}'
                                          ),
                                    ),
                              Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                  onPressed: () {
                                    pickImage(ImageSource.camera);
                                  },
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                              ),
                            ],
                          ),
                          // firstNameField,
                          const SizedBox(height: 20),
                          MyTextFormField(
                            myController: userNameEditingController,
                            fieldName: "Name",
                            myIcon: Icons.person_2_rounded,
                            iconColor: Colors.black,
                            keyboard: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the Name";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              userNameEditingController.text = value!;
                            },
                            errorMessage: "Enter the Name",
                            obscureText: false,
                          ),
                          const SizedBox(height: 20),
                          MyTextFormField(
                            myController: shopAddressEditingController,
                            fieldName: "Shop Address",
                            myIcon: Icons.business,
                            iconColor: Colors.black,
                            keyboard: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the Shop Address";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shopAddressEditingController.text = value!;
                            },
                            errorMessage: "Enter the Shop Address",
                            obscureText: false,
                          ),
                          const SizedBox(height: 20),
                          MyTextFormField(
                            myController: cityEditingController,
                            fieldName: "City",
                            myIcon: Icons.place,
                            iconColor: Colors.black,
                            keyboard: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the City";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              cityEditingController.text = value!;
                            },
                            errorMessage: "Enter the City",
                            obscureText: false,
                          ),
                          const SizedBox(height: 20),
                          MyTextFormField(
                            myController: stateEditingController,
                            fieldName: "State",
                            myIcon: Icons.place,
                            iconColor: Colors.black,
                            keyboard: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the State";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              stateEditingController.text = value!;
                            },
                            errorMessage: "Enter the State",
                            obscureText: false,
                          ),
                          const SizedBox(height: 20),
                          MyTextFormField(
                            myController: pincodeEditingController,
                            fieldName: "Pincode",
                            myIcon: Icons.pin,
                            iconColor: Colors.black,
                            keyboard: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter a valid Pincode";
                              }
                              if (!RegExp(r'^[1-9][0-9]{5}$').hasMatch(value)) {
                                return ("Please Enter a valid Pincode");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              pincodeEditingController.text = value!;
                            },
                            errorMessage: "Enter the Pincode",
                            obscureText: false,
                          ),
                          const SizedBox(height: 20),

                          MyButton(
                              family: 'Roboto',
                              size: 20.0,
                              message: "Edit Profile",
                              col1: const Color.fromARGB(255, 104, 103, 91),
                              col2: const Color.fromARGB(255, 0, 0, 0),
                              col3: const Color.fromARGB(255, 230, 220, 220),
                              col4: Colors.grey,
                              onPressed: () async {
                                String? documentId =
                                    await getDocumentIdBySerial(dealerEmail);
                                if (documentId != null) {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    if (userNameEditingController
                                            .text.isNotEmpty &&
                                        requiredEmail.isNotEmpty &&
                                        image != null &&
                                        stateEditingController
                                            .text.isNotEmpty &&
                                        cityEditingController.text.isNotEmpty &&
                                        shopAddressEditingController
                                            .text.isNotEmpty &&
                                        pincodeEditingController
                                            .text.isNotEmpty) {
                                      bool isUpdated = await auth.UpdateClaim(
                                        documentId,
                                        userNameEditingController.text,
                                        dealerEmail,
                                        image,
                                        stateEditingController.text,
                                        cityEditingController.text,
                                        shopAddressEditingController.text,
                                        pincodeEditingController.text,
                                        uidD,
                                      );
                                      if (isUpdated) {
                                        Get.to(() => HomeScreen());
                                      } else {
                                        Get.snackbar(
                                            "Error", "Failed to update profile",
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      }
                                    } else {
                                      Get.snackbar("Error",
                                          "Please fill all fields and select an image",
                                          snackPosition: SnackPosition.BOTTOM);
                                    }
                                  }
                                } else {
                                  Get.snackbar("Error", "Document not found",
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              }),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
