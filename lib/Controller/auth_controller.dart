import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tavanai_registration_app/Model/ClaimModel.dart' as mod;
import 'package:tavanai_registration_app/Model/ClientModel.dart' as mode;
import 'package:tavanai_registration_app/Model/UpdateDealerProfile.dart'
    as update;
import 'package:tavanai_registration_app/Model/user_model.dart' as model;
import 'package:tavanai_registration_app/Widget/Constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<File?> _pickedImage;

  late Rx<User?> _user;

  File? get ProfilePhoto => _pickedImage.value;

  User get user => _user.value!;

  RxString imagePath = "".obs;

  //upload to firestore storage

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebsaeStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> _uploadStorage(File image, String uid) async {
    Reference ref = firebsaeStorage.ref().child('profilePics').child(uid);

    UploadTask uploadTask = ref.putFile(image);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<bool> registerUser(
      String username,
      String email,
      String password,
      File? image,
      String state,
      String city,
      String shopAddress,
      String pincode) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          state.isNotEmpty &&
          city.isNotEmpty &&
          shopAddress.isNotEmpty &&
          pincode.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        String downloadUrl = await _uploadToStorage(image);

        model.User user = model.User(
          name: username,
          email: email,
          profilePhoto: downloadUrl,
          state: state,
          city: city,
          shopAddress: shopAddress,
          pincode: pincode,
          uid: cred.user!.uid,
        );

        await firestore
            .collection('DealerProfile')
            .doc(cred.user!.uid)
            .set(user.toJson());
        return true;
      } else {
        Get.snackbar(
          "Error Creating Account",
          'Please enter all the fields',
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Account",
        e.toString(),
      );
      return false;
    }
  }

  Future<bool> registerClient(
    String serial,
    String battery,
    String model,
    String date,
    String name,
    String address,
    String pincode,
    String email,
    String dealerEmail,
  ) async {
    try {
      if (serial.isNotEmpty &&
          battery.isNotEmpty &&
          model.isNotEmpty &&
          date.isNotEmpty &&
          name.isNotEmpty &&
          address.isNotEmpty &&
          pincode.isNotEmpty &&
          email.isNotEmpty &&
          dealerEmail.isNotEmpty) {
        mode.Client client = mode.Client(
          serial: serial,
          battery: battery,
          model: model,
          date: date,
          name: name,
          address: address,
          pincode: pincode,
          email: email,
          dealerEmail: dealerEmail,
        );

        await firestore.collection('ClientProfile').doc().set(client.toJson());
        return true;
      } else {
        Get.snackbar(
          "Error Creating Account",
          'Please enter all the fields',
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Account",
        e.toString(),
      );
      return false;
    }
  }

  Future<bool> ClaimRegister(
    String serial,
    String battery,
    String model,
    String dealerName,
    String clientName,
    String regisDate,
    String claimDate,
    String shopAddress,
    String clientAddress,
    String completed,
  ) async {
    try {
      if (serial.isNotEmpty &&
          battery.isNotEmpty &&
          model.isNotEmpty &&
          dealerName.isNotEmpty &&
          clientName.isNotEmpty &&
          regisDate.isNotEmpty &&
          claimDate.isNotEmpty &&
          shopAddress.isNotEmpty &&
          clientAddress.isNotEmpty &&
          completed.isNotEmpty) {
        mod.Claim claim = mod.Claim(
          serial: serial,
          battery: battery,
          model: model,
          dealerName: dealerName,
          clientName: clientName,
          regisDate: regisDate,
          claimDate: claimDate,
          shopAddress: shopAddress,
          clientAddress: clientAddress,
          completed: completed,
        );

        await firestore.collection('ClaimRegister').doc().set(claim.toJson());
        return true;
      } else {
        Get.snackbar(
          "Error Creating Account",
          'Please enter all the fields',
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Account",
        e.toString(),
      );
      return false;
    }
  }

  Future<bool> UpdateClaim(
      String documentId,
      String username,
      String email,
      File? image,
      String state,
      String city,
      String shopAddress,
      String pincode,
      String uid) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          state.isNotEmpty &&
          city.isNotEmpty &&
          shopAddress.isNotEmpty &&
          pincode.isNotEmpty &&
          image != null &&
          uid.isNotEmpty) {
        String downloadUrl = await _uploadStorage(image, uid);

        update.UpdateProfile updateP = update.UpdateProfile(
            name: username,
            email: email,
            profilePhoto: downloadUrl,
            state: state,
            city: city,
            shopAddress: shopAddress,
            pincode: pincode,
            uid: uid);

        await firestore
            .collection('DealerProfile')
            .doc(documentId)
            .set(updateP.toJson());
        print("Profile updated successfully.");
        return true;
      } else {
        Get.snackbar(
          "Error Creating Account",
          'Please enter all the fields',
        );
        print("Error: One or more fields are empty or null.");
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Account",
        e.toString(),
      );
      print("Exception caught: $e");
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        print("Log Success");
        return true;
      } else {
        Get.snackbar(
          "Error Logging in",
          'Please enter all the fields',
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Account",
        e.toString(),
      );
      return false;
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }

  resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      Get.snackbar("Email Sent", "Password Reset Email has been sent");
    } catch (e) {
      Get.snackbar("User Not Found", "No user fount for that email");
    }
  }
}
