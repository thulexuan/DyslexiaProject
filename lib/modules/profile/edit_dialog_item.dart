import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyslexia_project/modules/common/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditDialog extends StatefulWidget {

  @override
  State<EditDialog> createState() => _EditDialogState();

  TextEditingController controller;
  String fieldName;

  EditDialog({
    required this.controller,
    required this.fieldName
});
}

class _EditDialogState extends State<EditDialog> {

  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: widget.controller,
      ),
      actions: [
        TextButton(
            onPressed: () async {
              userController.saveToDb(widget.fieldName, widget.controller.text.trim());
              if (widget.fieldName == "fullname") {
                userController.fullName.value = widget.controller.text.trim();
              } else if (widget.fieldName == "phoneNumber") {
                userController.phoneNumber.value = widget.controller.text.trim();
              }
              Navigator.of(context).pop();
            },
            child: Text("Cập nhật")
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Bỏ qua")
        ),
      ],
    );
  }
}
