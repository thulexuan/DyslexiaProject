import 'package:dyslexia_project/modules/intro/first_time_login_page.dart';
import 'package:dyslexia_project/modules/intro/splash_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: IntroductionScreen(
        rawPages: [
          SplashItem(title: 'Đọc văn bản', body: 'Chụp ảnh hoặc chọn ảnh từ thư viện để đọc văn bản', imageUrl: 'reading_splash_page_1.jfif',),
          SplashItem(title: 'Tùy chỉnh văn bản', body: 'Làm văn bản trở nên dễ đọc nhất đối với bạn', imageUrl: 'reading_splash_page_2.jfif',),
          SplashItem(title: 'Làm bài test', body: 'Thực hiện bài test để có trải nghiệm tốt nhất ngay từ đầu', imageUrl: 'take_test_splash_page_1.jfif',),
        ],
        showSkipButton: true,
        skip: Icon(Icons.skip_next, size: MediaQuery.of(context).size.width / 16,),
        next: Text("Tiếp", style: Theme.of(context).textTheme.bodySmall,),
        done: Text("Xong", style: Theme.of(context).textTheme.bodySmall,),
        onDone: () {
          // On Done button pressed
          Get.to(const FirstTimeLoginPage());
        },
        onSkip: () {
          // On Skip button pressed
        },
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).colorScheme.secondary,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)
          ),
        ),
      ),
    );
  }
}
