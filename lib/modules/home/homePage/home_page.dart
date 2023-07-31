import 'package:dyslexia_project/modules/home/readText/views/read_options_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'option_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 100,),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              childAspectRatio: 4/5,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  ReadOptions()),
                      );
                    },
                    child: OptionItem(title: "Đọc văn bản", description: "Tùy chỉnh giúp đọc văn bản dễ dàng hơn", image: "image")
                ),
                OptionItem(title: "Luyện tập", description: "Luyện nghe qua thư viện sách nói", image: "image"),
                OptionItem(title: "Kiểm tra", description: "Thực hiện các bài kiểm tra kỹ năng đọc hiểu", image: "image"),
                OptionItem(title: "Quá trình", description: "Theo dõi quá trình học tập", image: "image")
              ],
            )
          ),
        ],
      ),
    );
  }
}
