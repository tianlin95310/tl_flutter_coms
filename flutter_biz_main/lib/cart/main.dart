import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biz_main/home/components.dart';
import 'package:tl_flutter_common/main.dart';
class CartPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return CartPageState();
  }
}

class CartPageState extends BaseState with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabs = ['新闻', '体育', '财经', '娱乐', '科技', '汽车', '视频', '房产', '游戏'];

  int _count = 20;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Widget getTabBar(double height) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Container(
        color: TLThemes.getProvider(context).primaryColor,
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.black,
          // indicatorColor: Colors.transparent,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return way(context);
  }

  Widget way(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            // 巧妙的解决了去掉Tabbar，页面出现在状态栏的问题
            // 控制折叠后的Tabbar固定在顶部
            pinned: true,
            toolbarHeight: 0,
            backgroundColor: TLThemes.getProvider(context).primaryColor,
            // floating: true,
            // 为true是AppBar会自动回弹
            // snap: true,
            /// SliverAppBar展开的高度
            expandedHeight: 160,
            shadowColor: Colors.transparent,
            // 跟随滑动的title
            flexibleSpace: FlexibleSpaceBar(
              // 背景消失的动画方式
              collapseMode: CollapseMode.parallax,
              background: Container(
                height: 160,
                color: TLThemes.getProvider(context).primaryColor,
                child: Center(child: Text('NestedScrollView has a scroll bug\nOnly PageStorageKey is not enough')),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
              child: getTabBar(48),
              size: Size(double.infinity, 48),
            ),
          )
        ];
      },
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: tabs.map((String key) {
          // only use PageStorageKey, with ExtendedNestedScrollView,
          // it does't wort when one tab scroll to index 0, other tab will scroll to index 0 too, except keepAlive
          return ListView.builder(
            key: PageStorageKey(key),
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
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
            itemCount: _count,
          );
        }).toList(),
      ),
    );
  }
}
