import 'package:flutter/material.dart';
import 'package:flutter_biz_main/home/main.dart';
import 'package:flutter_biz_main/news/main.dart';
import 'package:flutter_biz_main/setting/main.dart';
import 'package:tl_flutter_common/main.dart';

final Map<String, WidgetBuilder> mainRoutes = {
  'home': (BuildContext context, {arguments}) => MainPage(),
};

void main() async {
  // read app setting data
  runApp(MyApp({...mainRoutes, ...commonRoutes}, {}, {'theme': 0, 'language': 'en-US'}));
}

class MainPage extends BaseStatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> getState() {
    return _MainPageState();
  }
}

class _MainPageState extends BaseState<MainPage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget getBody(BuildContext context) {
    print('---main getBody---');
    print(MediaQuery.of(context).devicePixelRatio);
    print(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: Colors.white,
      // 保留page的状态
      // body: IndexedStack(children: [HomePage(), NewsPage(), SettingPage()], index: _currentIndex,),
      // body: [HomePage(), NewsPage(), SettingPage()][_currentIndex],
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [HomePage(), NewsPage(), SettingPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          print(index);
          setState(() {
            _currentIndex = index;
            _tabController.index = index;
          });
        },
        selectedItemColor: TLThemes.getProvider(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            label: I18n.of(context).main,
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: I18n.of(context).news,
            icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            label: I18n.of(context).mine,
            icon: Icon(Icons.account_box_sharp),
          ),
        ],
      ),
    );
  }
}
