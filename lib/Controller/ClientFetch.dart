import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tavanai_registration_app/Model/ClientFetchModel.dart';

class RegistrationController extends GetxController {
  var regis = <Registration>[].obs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var filteredModels = <Registration>[].obs;

  Future<void> fetchAllModels() async {
    try {
      QuerySnapshot query = await _db.collection('ClientProfile').get();
      regis.value = query.docs.map((doc) {
        Registration reg = Registration.fromFirestore(doc);
        // print('Fetched Model: ${model.name}, ${model.email}, ${model.city}');
        return reg;
      }).toList();
      filteredModels.value = List.from(regis);
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void filterModels(String query) {
    filteredModels.value = regis.where((model) {
      // Case-insensitive search by dealer name
      return model.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
