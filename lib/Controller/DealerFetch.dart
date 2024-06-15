import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tavanai_registration_app/Controller/emailController.dart';
import 'package:tavanai_registration_app/Model/DealerFetchModel.dart';

class MyModel1Controller extends GetxController {
  var models = <MyModel1>[].obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthenticationController authController =
      Get.put(AuthenticationController());

  Future<void> fetchAllModels() async {
    try {
      QuerySnapshot query = await _db.collection('ClientProfile').get();
      models.value = query.docs.map((doc) {
        MyModel1 model = MyModel1.fromFirestore(doc);
        // print('Fetched Model: ${model.name}, ${model.email}, ${model.city}');
        return model;
      }).toList();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
