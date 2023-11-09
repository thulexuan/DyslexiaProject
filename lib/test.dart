import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
   Test({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = 'Hãy chọn chữ bạn cho là dễ nhìn nhất';
    // controller.text = 'This is a text';
    return Scaffold(
      appBar: AppBar(title: Text('Test Page'),),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
            ),
            ElevatedButton(
                onPressed: () {
                  SoundFunction().getVoices();
                },
                child: Text('Speak')
            )
          ],
        ),
      ),
    );
  }
}
