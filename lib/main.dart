import 'package:dyslexia_project/test.dart';
import 'package:dyslexia_project/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/auth/views/login.dart';
import 'modules/tests/views/testCustomizePage.dart';
import 'overview_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: OverviewPage(),
    );
  }
}
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(home: MyHomePage(),debugShowCheckedModeBanner: false,);
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final _textController = TextEditingController();
//
//   late Uint8List _imageData = Uint8List(0);
//   bool _isLoading = false; // Add this line
//
//
//   void _convertTextToImage() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     const baseUrl = 'https://api.stability.ai';
//     final url = Uri.parse(
//         '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-0/text-to-image');
//
//     // Make the HTTP POST request to the Stability Platform API
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer sk-OELdgnxMoyLfFPi6vVL3CX9z9VyO2LGUxy4pxY1vq6tAPsBk',
//         'Accept': 'image/png',
//       },
//       body: jsonEncode({
//         'cfg_scale': 7,
//         'clip_guidance_preset': 'FAST_BLUE',
//         'height': 512,
//         'width': 512,
//         'samples': 1,
//         'steps': 50,
//         'text_prompts': [
//           {
//             'text': _textController.text ?? '',
//             'weight': 1,
//           }
//         ],
//       }),
//     );
//
//     setState(() {
//       _isLoading = false;
//     });
//
//     if (response.statusCode != 200) {
//       _showErrorDialog('Failed to generate image');
//     }
//     else {
//       try {
//         _imageData = (response.bodyBytes);
//         setState(() {});
//       } on Exception
//       catch (e){
//         _showErrorDialog('Failed to generate image');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) =>
//       SafeArea(
//         child: Scaffold(
//           backgroundColor:Colors.black54,
//           appBar: AppBar(title: const Text('ThunderBolt'),centerTitle: true,backgroundColor: Colors.deepPurple,
//
//           ),
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 controller: _textController,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter your input',
//                   fillColor: Colors.white,
//                   filled: true,
//                   // contentPadding: const EdgeInsets.all(16),
//                   // labelStyle: TextStyle(color: Colors.red),
//                 ),
//               ),
//               SizedBox(height: 30,),
//               Container(
//                 width: 150,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//
//                   ),
//                   onPressed: _convertTextToImage,
//                   child: _isLoading
//                       ? const SizedBox(height:30, width:30,child: CircularProgressIndicator(color: Colors.redAccent))
//                       : const Text('Generate Image'),
//                 ),
//               ),
//               SizedBox(height: 30,),
//               if (_imageData != null) Image.memory(_imageData)
//             ],
//           ),
//         ),
//       );
//
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Ok'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             )
//           ],
//         );
//       },
//     );
//   }
// }