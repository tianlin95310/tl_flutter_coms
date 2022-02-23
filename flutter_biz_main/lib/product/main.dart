import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';

class ProductPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return ProductPageState();
  }
}

class ProductPageState extends BaseState with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabs = ['新闻', '体育', '财经', '娱乐', '科技', '汽车', '视频', '房产', '游戏'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  TabBar getTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.black,
      // indicatorColor: Colors.transparent,
      tabs: tabs.map((e) => Tab(text: e)).toList(),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [
        Padding(padding: MediaQuery.of(context).padding),
        Expanded(
          child: Column(
            children: [
              getTabBar(),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: tabs.map((String key) {
                    // PageStorage即可实现保留滚动外置,without NestedScrollView
                    return ListView.builder(
                      key: PageStorageKey(key),
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          margin: EdgeInsets.all(16),
                          child: Container(
                            height: 80,
                            child: Text(key + '$index'),
                            padding: EdgeInsets.all(16),
                          ),
                        );
                      },
                      itemCount: 20,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
