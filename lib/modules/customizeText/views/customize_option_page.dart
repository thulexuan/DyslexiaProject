
import 'package:dyslexia_project/modules/common/controllers/sound.dart';
import 'package:dyslexia_project/modules/customizeText/views/sound_customize_option_page.dart';
import 'package:dyslexia_project/modules/customizeText/views/text_customize_option_page.dart';
import 'package:flutter/material.dart';

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
        title: Text('Tùy chỉnh'),
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
              tabs: const [
                Tab(child: Text('Văn bản',
                  style: TextStyle(fontSize: 18,),)
                ),
                Tab(child: Text('Âm thanh',
                  style: TextStyle(fontSize: 18,),),
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
