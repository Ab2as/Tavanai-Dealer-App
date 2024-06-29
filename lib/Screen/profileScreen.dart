import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tavanai_registration_app/Controller/auth_controller.dart';
import 'package:tavanai_registration_app/Controller/dummyFetch.dart';
import 'package:tavanai_registration_app/Model/dummyModel.dart';
import 'package:tavanai_registration_app/Screen/Auth/LoginScreen.dart';
import 'package:tavanai_registration_app/Screen/EditProfileScreen.dart';
import 'package:tavanai_registration_app/Screen/SplashScreen.dart';
import 'package:tavanai_registration_app/Widget/ElevatedButtonModel.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final MyModelController controller = Get.put(MyModelController());
  final String requiredEmail = 'qwert@zxc.com';
  final FirebaseAuth auths = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.put(AuthController());
    User? currentUser = auths.currentUser;
    String dealerEmail = currentUser?.email ?? '';
    controller.fetchAllModels();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.models.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          MyModel? model = controller.models.firstWhereOrNull(
            (model) => model.email == dealerEmail,
          );

          // Check if the model was found
          if (model == null) {
            return const Center(
                child: Text('No data available for the current user email'));
          }

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(image: NetworkImage('${model.photo}')),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${model.email}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayFair'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    family: 'Roboto',
                    size: 20.0,
                    message: "Edit Profile",
                    onPressed: () {
                      Get.to(EditProfileScreen(
                          name: model.name,
                          address: model.shopAddress,
                          city: model.city,
                          state: model.state,
                          pincode: model.pincode));
                    },
                    col1: const Color.fromARGB(255, 104, 103, 91),
                    col2: Colors.black,
                    col3: Colors.grey,
                    col4: Colors.white,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  ProfileMenuWidget(
                    title: '${model.name}',
                    icon: Icons.person,
                    endIcon: true,
                    onPress: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileMenuWidget(
                    title: '${model.shopAddress}',
                    icon: Icons.home,
                    endIcon: true,
                    onPress: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileMenuWidget(
                    title: '${model.city}',
                    icon: Icons.location_city,
                    endIcon: true,
                    onPress: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileMenuWidget(
                    title: '${model.state}',
                    icon: Icons.location_city_rounded,
                    endIcon: true,
                    onPress: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileMenuWidget(
                    title: '${model.pincode}',
                    icon: Icons.pin_drop_rounded,
                    endIcon: true,
                    onPress: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ProfileMenuWidget(
                    title: "Logout",
                    icon: Icons.logout_rounded,
                    endIcon: true,
                    textColor: Colors.red,
                    onPress: () async {
                      // auth.signOut();
                      var sharedPref = await SharedPreferences.getInstance();
                      sharedPref.setBool(SplashScreenState.KEYLOGIN, false);
                      Get.offAll(LoginScreen());
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    required this.title,
    required this.icon,
    required this.endIcon,
    this.textColor,
    required this.onPress,
    super.key,
  });

  final String title;
  final IconData icon;
  final bool endIcon;
  final Color? textColor;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 167, 164, 164),
                offset: Offset(4.0, 4.0),
                blurRadius: 15,
                spreadRadius: 1.0),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15,
              spreadRadius: 1.0,
            )
          ]),
      child: ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.black.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            color: textColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ptserif',
              color: textColor),
        ),
      ),
    );
  }
}
