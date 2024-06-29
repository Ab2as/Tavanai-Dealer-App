import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tavanai_registration_app/Controller/auth_controller.dart';
import 'package:tavanai_registration_app/Screen/HomeScreen.dart';
import 'package:tavanai_registration_app/Widget/ElevatedButtonModel.dart';
import 'package:tavanai_registration_app/Widget/TextFieldModel.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final userNameEditingController = new TextEditingController();
  final userAddressEditingController = new TextEditingController();
  final serialEditingController = new TextEditingController();
  final pincodeEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final TextEditingController otpController = TextEditingController();

  AuthController authController = Get.put(AuthController());
  final FirebaseAuth auths = FirebaseAuth.instance;

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("Automotive Battery"), value: "Automotive Battery"),
      DropdownMenuItem(
          child: Text("Inverter Battery"), value: "Inverter Battery"),
      DropdownMenuItem(
          child: Text("E-Rickshaw Battery"), value: "E-Rickshaw Battery"),
    ];

    return menuItems;
  }

  List<DropdownMenuItem<String>> get automotive {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("TIB-105 18-M"), value: "TIB-105 18-M"),
      DropdownMenuItem(child: Text("TIB-110 18-M"), value: "TIB-110 18-M"),
      DropdownMenuItem(child: Text("TIB-400 12-M"), value: "TIB-400 12-M"),
      DropdownMenuItem(child: Text("TIB-450 18-M"), value: "TIB-450 18-M"),
      DropdownMenuItem(child: Text("TIB-600 12-M"), value: "TIB-600 12-M"),
      DropdownMenuItem(child: Text("TIB-700 18-M"), value: "TIB-700 18-M"),
      DropdownMenuItem(child: Text("TIB-750 12-M"), value: "TIB-750 12-M"),
      DropdownMenuItem(child: Text("TIB-850 18-M"), value: "TIB-850 18-M"),
      DropdownMenuItem(child: Text("TIB-1350 12-M"), value: "TIB-1350 12-M"),
      DropdownMenuItem(child: Text("TIB-1500 18-M"), value: "TIB-1500 18-M"),
      DropdownMenuItem(child: Text("TIT-180 18-M"), value: "TIT-180 18-M"),
      DropdownMenuItem(child: Text("TIT-200 24-M"), value: "TIT-200 24-M"),
      DropdownMenuItem(child: Text("TIT-220 24-M"), value: "TIT-220 24-M"),
      DropdownMenuItem(child: Text("TIT-250 36-M"), value: "TIT-250 36-M"),
      DropdownMenuItem(
          child: Text("TIT-200 JUMBO 24-M"), value: "TIT-200 JUMBO 24-M"),
      DropdownMenuItem(
          child: Text("TIT-220 JUMBO 24-M"), value: "TIT-220 JUMBO 24-M"),
      DropdownMenuItem(child: Text("TER-105 6-M"), value: "TER-105 6-M"),
      DropdownMenuItem(child: Text("TER-120 6-M"), value: "TER-120 6-M"),
      DropdownMenuItem(child: Text("TIB-130 9-M"), value: "TIB-130 9-M"),
      DropdownMenuItem(child: Text("TIB-140 9-M"), value: "TIB-140 9-M"),
    ];

    return menuItems;
  }

  String? selectedValue = null;
  String? selectedValue1 = null;

  String message = "";
  bool? _value = false;
  String messageTerm =
      "01. The warranty of your battery shall become null & void if: The battery is transferred to a third party, The battery is found to be mishandled, The battery is not connected properly & is deployed to wrong use. The battery is found to be damaged due to improper handling by unauthorised personnel, fire, excess heat, theft, accident, wilful abuse or overcharging, Any electrolyte or material other than battery grade distilled water is used in the battery.\n 02. Our batteries are warranted solely against poor workmanship and use of faulty material, Consequent liabilities will not be entertained.\n 03. It is the responsibility of the customer to bring suspected battery to the nearest authorised service centre incase of any trouble.\n04. In case your battery develops a fault, you may contact our Uttar Pradesh Authorised Service Provider.";

  @override
  Widget build(BuildContext context) {
    User? currentUser = auths.currentUser;
    String dealerEmail = currentUser?.email ?? '';

    Future sendEmail() async {
      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
      const serviceId = "service_xsbjpn6";
      const templateId = "template_hbq0si9";
      const publicKey = "5WtJrjQbryXrJigl0";
      final response = await http.post(url,
          headers: {
            'origin': 'https://localhost',
            'Content-Type': 'application/json'
          },
          body: json.encode({
            "service_id": serviceId,
            "template_id": templateId,
            "user_id": publicKey,
            "template_params": {
              "name": userNameEditingController.text,
              "serial": serialEditingController.text,
              "battery": selectedValue.toString(),
              "model": selectedValue1.toString(),
              "date": currentDate,
              "dealerEmail": dealerEmail,
              "send_to": emailEditingController.text,
              "message": messageTerm,
            },
          }));
      print(response.body);
      return response.statusCode;
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.grey, Colors.white],
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back),
                          iconSize: 30.0,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Registration Screen",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    // firstNameField,
                    const SizedBox(height: 20),

                    MyTextFormField(
                      obscureText: false,
                      myController: serialEditingController,
                      fieldName: "Serial Number",
                      myIcon: Icons.numbers_rounded,
                      iconColor: Colors.black,
                      keyboard: TextInputType.number,
                      errorMessage: "Please enter a Serial Number",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a Serial Number";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        serialEditingController.text = value!;
                      },
                    ),
                    const SizedBox(height: 20),

                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.battery_0_bar_rounded,
                            color: Colors.black,
                          ),
                          labelText: "Select Battery",
                          labelStyle:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                        ),
                        validator: (value) =>
                            value == null ? "Select a Battery" : null,
                        dropdownColor: Colors.white.withOpacity(0.7),
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        items: dropdownItems),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),

                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.mode,
                            color: Colors.black,
                          ),
                          labelText: "Select Model",
                          labelStyle:
                              TextStyle(color: Colors.white.withOpacity(0.9)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                        ),
                        validator: (value) =>
                            value == null ? "Select a Model" : null,
                        dropdownColor: Colors.white.withOpacity(0.7),
                        value: selectedValue1,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue1 = newValue!;
                          });
                        },
                        items: automotive),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: currentDate,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.date_range_rounded,
                          color: Colors.black,
                        ),
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.9)),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(height: 20),

                    MyTextFormField(
                      myController: userNameEditingController,
                      fieldName: "Client Name",
                      myIcon: Icons.person_2_rounded,
                      iconColor: Colors.black,
                      keyboard: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a User Name";
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
                      myController: userAddressEditingController,
                      fieldName: "Client Address",
                      myIcon: Icons.business,
                      iconColor: Colors.black,
                      keyboard: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter an Address";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userAddressEditingController.text = value!;
                      },
                      errorMessage: "Enter the Shop Address",
                      obscureText: false,
                    ),

                    const SizedBox(height: 20),
                    MyTextFormField(
                      myController: pincodeEditingController,
                      fieldName: "Client Pincode",
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
                    MyTextFormField(
                      myController: emailEditingController,
                      fieldName: "Client Email",
                      myIcon: Icons.email_rounded,
                      iconColor: Colors.black,
                      keyboard: TextInputType.emailAddress,
                      errorMessage: "Please enter a correct Email",
                      obscureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter an Email";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please Enter a valid email");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailEditingController.text = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CheckboxListTile(
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: const Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "fantasy",
                          ),
                        ),
                        subtitle: Text(
                          messageTerm,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                            fontFamily: "fantasy",
                          ),
                        ),
                        value: _value,
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyButton(
                        family: 'Roboto',
                        size: 20.0,
                        message: "Register",
                        col1: const Color.fromARGB(255, 73, 75, 77),
                        col2: Colors.black,
                        col3: Colors.grey,
                        col4: Colors.grey,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            bool isRegistered =
                                await authController.registerClient(
                              serialEditingController.text,
                              selectedValue.toString(),
                              selectedValue1.toString(),
                              currentDate,
                              userNameEditingController.text,
                              userAddressEditingController.text,
                              pincodeEditingController.text,
                              emailEditingController.text,
                              dealerEmail,
                            );
                            if (isRegistered && _value == true) {
                              sendEmail();
                              Get.dialog(
                                Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Success',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 20.0),
                                        const Text(
                                          'Registration successful!',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.grey),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20.0),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.to(() => HomeScreen());
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false,
                              );
                            } else {
                              Get.snackbar("Error", "Failed to upload profile",
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          } else {
                            Get.snackbar(
                              "Registration Error",
                              "Invalid Email or Details",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        }),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
