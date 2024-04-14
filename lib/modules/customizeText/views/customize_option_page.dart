
import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:dyslexia_project/modules/customizeText/views/sound_customize_option_page.dart';
import 'package:dyslexia_project/modules/customizeText/views/text_customize_option_page.dart';
import 'package:dyslexia_project/modules/readText/controllers/recognize_text_controller.dart';
import 'package:dyslexia_project/modules/readText/views/display_text_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomizeOptionPage extends StatefulWidget {
  const CustomizeOptionPage({Key? key}) : super(key: key);

  @override
  State<CustomizeOptionPage> createState() => _CustomizeOptionPageState();
}

class _CustomizeOptionPageState extends State<CustomizeOptionPage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    SoundFunction().stopSpeaking();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tùy chỉnh', style: Theme.of(context).textTheme.labelSmall,),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back), // Use the arrow icon
        //   onPressed: () {
        //   },
        // ),
        toolbarHeight: MediaQuery.of(context).size.height / 12,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.teal,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tab(child: Text('Văn bản',
                    style: Theme.of(context).textTheme.bodyMedium)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tab(child: Text('Âm thanh',
                    style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            // width: double.maxFinite,
            // height: MediaQuery.of(context).size.height - 170,
            child: TabBarView(
              controller: _tabController,
              children: const [
                TextCustomizeOptionPage(),
                SoundCustomizeOptionPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
