import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  var fullName = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;

  Future<void> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email',
        isEqualTo: prefs.getString('email')) // add your condition here
        .get();

    // get data from the first document in the snapshot
    final Object? data =
    snapshot.docs.isNotEmpty ? snapshot.docs.first.data() : {};

    var user_fullName = data != null && data is Map<String, dynamic>
        ? data['fullname']
        : 'no name' ;

    var user_phone = data != null && data is Map<String, dynamic>
        ? data['phoneNumber']
        : 'no phone' ;

    var user_email = data != null && data is Map<String, dynamic>
        ? data['email']
        : 'no email' ;;

    fullName.value = user_fullName;
    email.value = user_email;
    phoneNumber.value = user_phone;

  }

  // update data

  Future<void> saveToDb(String fieldName, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email',
        isEqualTo: prefs.getString('email')) // add your condition here
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs[0]
          .reference
          .update({
        fieldName : value
      });
    }


  }
}