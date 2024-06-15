import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tavanai_registration_app/Controller/emailController.dart';
import 'package:tavanai_registration_app/Model/dummyModel.dart';

class MyModelController extends GetxController {
  var models = <MyModel>[].obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthenticationController authController =
      Get.put(AuthenticationController());

  Future<void> fetchAllModels() async {
    try {
      QuerySnapshot query = await _db.collection('DealerProfile').get();
      models.value = query.docs.map((doc) {
        MyModel model = MyModel.fromFirestore(doc);
        // print('Fetched Model: ${model.name}, ${model.email}, ${model.city}');
        return model;
      }).toList();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  MyModel? getModelByEmail() {
    String? email = authController.userEmail;
    if (email == null) return null;
    return models.firstWhereOrNull((model) => model.email == email);
  }
}
