import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/common/controllers/user_controller.dart';
import 'package:dyslexia_project/modules/profile/edit_dialog_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();

}

class _EditProfilePageState extends State<EditProfilePage> {

  final userController = Get.put(UserController());
   var fullNameController = TextEditingController();
   var phoneNumberController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getUserInfo();
    fullNameController.text = userController.fullName.value;
    phoneNumberController.text = userController.phoneNumber.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chỉnh sửa thông tin'),),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 15,),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  border: Border.all(
                      color: Colors.white
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/images/avatar_default.png', fit: BoxFit.contain,),
                ),
              ),
            ),

            SizedBox(height: 20,),

            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
              child: Text('Tên', style: TextStyle(fontWeight: FontWeight.bold),),
            ),

            // phone number field
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(userController.fullName.value)),
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditDialog(controller: fullNameController, fieldName: 'fullname',);
                                }
                            );
                          },
                          child: Icon(Icons.edit)
                      )
                    ],
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
              child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold),),
            ),

            // email field
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(userController.email.value),
                    ],
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
              child: Text('Số điện thoại', style: TextStyle(fontWeight: FontWeight.bold),),
            ),

            // phone number field
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(userController.phoneNumber.value)),
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditDialog(controller: phoneNumberController, fieldName: 'phoneNumber',);
                                }
                            );
                          },
                          child: Icon(Icons.edit)
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,

    );
  }
}
