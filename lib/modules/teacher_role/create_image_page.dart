
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateImagePage extends StatefulWidget {
  const CreateImagePage({Key? key}) : super(key: key);

  @override
  State<CreateImagePage> createState() => _CreateImagePageState();
}

class _CreateImagePageState extends State<CreateImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tạo ảnh', style: Theme.of(context).textTheme.labelSmall,), toolbarHeight: MediaQuery.of(context).size.height / 12,),
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: selectedImagePath == '' ? Text('Chưa chọn được ảnh') : Image.file(
                File(selectedImagePath),
                width: Get.width,
                //height: 400,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Text('Chọn ảnh')
            ),
            ElevatedButton(
                onPressed: () async {
                  // await uploadFile(File(selectedImagePath), 'uploads/myfile.txt');
                },
                child: Text('Tải lên')
            )
          ],
        ),
      ),
    );
  }

  String selectedImagePath = '';

  getImage(ImageSource imageSource) async{
    print("get image oke");
    final pickedFile= await ImagePicker().pickImage(source: imageSource);
    if(pickedFile!=null){
      setState(() {
        selectedImagePath = pickedFile.path;
      });
    }
    else{
      Get.snackbar(
          "Error", "image is not selected",
          backgroundColor: Colors.red);
    }
  }

  // Future<String> uploadImage(File imageFile) async {
  //   // Create a reference to the location you want to upload to in Firebase Storage
  //   Reference storageReference = FirebaseStorage.instance.ref().child('images/imageName.jpg');
  //
  //   // Upload the file to Firebase Storage
  //   UploadTask uploadTask = storageReference.putFile(imageFile);
  //
  //   // Await for the upload to complete
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  //
  //   // Return the download URL of the uploaded image
  //   String downloadURL = await taskSnapshot.ref.getDownloadURL();
  //   return downloadURL;
  // }

}
