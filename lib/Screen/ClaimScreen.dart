import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tavanai_registration_app/Controller/auth_controller.dart';
import 'package:tavanai_registration_app/Screen/CheckClaim.dart';
import 'package:tavanai_registration_app/Widget/ElevatedButtonModel.dart';
import 'package:tavanai_registration_app/Widget/TextFieldModel.dart';

class ClaimScreen extends StatefulWidget {
  const ClaimScreen({Key? key}) : super(key: key);

  @override
  _ClaimScreenState createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller

  final serialEditingController = new TextEditingController();

  AuthController authController = Get.put(AuthController());

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
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
                          width: 30,
                        ),
                        const Expanded(
                          child: Text(
                            'Claim Screen',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold),
                          ),
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

                          // BorderSide(color: Colors.blue, width: 2),

                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(height: 20),

                    MyButton(
                        family: 'Roboto',
                        size: 20.0,
                        message: "Claim",
                        col1: const Color.fromARGB(255, 73, 75, 77),
                        col2: Colors.black,
                        col3: Colors.grey,
                        col4: Colors.grey,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            showDialog(
                              context: context,
                              builder: (context) => DCheckclaim(
                                  serial: serialEditingController.text,
                                  date: currentDate),
                            );
                          } else {
                            Get.snackbar(
                              "Claim Error",
                              "Invalid Serial Number",
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
