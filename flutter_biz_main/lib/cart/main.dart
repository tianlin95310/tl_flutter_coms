import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tl_flutter_common/main.dart';
import 'package:tl_flutter_common/widget/smart-refresher-views.dart';
class CartPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return CartPageState();
  }
}

class CartPageState extends BaseState with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabs = ['新闻', '体育', '财经', '娱乐', '科技', '汽车', '视频', '房产', '游戏'];
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _refreshController = RefreshController();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // _count = 20;
    });
    _refreshController?.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      // _count += 20;
    });
    _refreshController?.loadComplete();
  }

  Widget getTabBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
        color: TLThemes.getProvider(context).textColor.withBlue(100),
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
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: SmartRefresherViews.getHeader(context),
      footer: SmartRefresherViews.getFooter(context),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,
        pinnedHeaderSliverHeightBuilder: () {
          print('MediaQuery.of(context).padding' + MediaQuery.of(context).padding.toString());
          return MediaQuery.of(context).padding.top + kToolbarHeight;
        },
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // 巧妙的解决了去掉Tabbar，页面出现在状态栏的问题
              toolbarHeight: 0,
              // 控制折叠后的Tabbar固定在顶部
              pinned: true,
              // 固定的title
              // title: Text(I18n.getProvider(context).news),
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
                  color: TLThemes.getProvider(context).primaryColor,
                  child: Container(
                    height: 160,
                    color: TLThemes.getProvider(context).primaryColor,
                    child: Center(child: Text('only PageStorageKey does\'t work')),
                  ),
                ),
              ),
              bottom: getTabBar(),
            ),
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
    );
  }
}
