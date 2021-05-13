import 'package:flutter/material.dart';
import 'package:flutter_biz_main/home/main.dart';
import 'package:flutter_biz_main/news/main.dart';
import 'package:tl_flutter_common/main.dart';

import 'setting/main.dart';

final Map<String, WidgetBuilder> mainRoutes = {
  'home': (BuildContext context, { arguments }) => MainPage(),
  'SettingPage': (BuildContext context, { arguments }) => SettingPage(),
};

class MainPage extends BaseStatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> getState() {
    return _MainPageState();
  }
}

class _MainPageState extends BasePageTitleState<MainPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  String getTitle() {
    if (_currentIndex == 0) {
      return I18n.of(context).main;
    } else if (_currentIndex == 1) {
      return I18n.of(context).news;
    } else {
      return I18n.of(context).mine;
    }
  }
  @override
  Widget getBody(BuildContext context) {
    return Scaffold(
      body: [HomePage(), NewsPage(), SettingPage()][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          print(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(label: I18n.of(context).main, icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: I18n.of(context).news, icon: Icon(Icons.message)),
          BottomNavigationBarItem(label: I18n.of(context).mine, icon: Icon(Icons.account_box_sharp)),
        ],
      ),
    );
  }
}
