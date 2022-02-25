import 'package:flutter/material.dart';
import 'package:flutter_biz_main/cart/main.dart';
import 'package:flutter_biz_main/home/main.dart';
import 'package:flutter_biz_main/news/main.dart';
import 'package:flutter_biz_main/product/main.dart';
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
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget getBody(BuildContext context) {
    print('---main getBody---');
    print(MediaQuery.of(context).devicePixelRatio);
    print(MediaQuery.of(context).size);
    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [HomePage(), NewsPage(), CartPage(), ProductPage(), SettingPage()],
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
        selectedLabelStyle: TextStyle(color: TLThemes.getProvider(context).primaryColor, fontSize: 12),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 12),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
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
            label: I18n.of(context).cart,
            icon: Icon(Icons.car_rental),
          ),
          BottomNavigationBarItem(
            label: I18n.of(context).product,
            icon: Icon(Icons.production_quantity_limits),
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
