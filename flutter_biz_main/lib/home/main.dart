import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biz_main/components.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tl_flutter_common/main.dart';
import 'package:tl_flutter_common/widget/smart-refresher-views.dart';

class HomePage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return HomePageState();
  }
}

class HomePageState extends BaseState {
  String url =
      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fzz.800zhe.com.cn%2Fwp-content%2Fuploads%2F2018%2F07%2F50430.jpg&refer=http%3A%2F%2Fzz.800zhe.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627614541&t=1148cc23b00e8f71a07a37373ac8b8a6';

  RefreshController _refreshController;

  int _count = 20;

  List<Widget> getActions(BuildContext context) {
    return [
      getIcon(Icons.baby_changing_station),
      getIcon(Icons.backpack),
      getIcon(Icons.backup_table),
      getIcon(Icons.batch_prediction),
    ];
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
  }

  getIcon(IconData iconData) {
    return Material(
      color: TLThemes.getProvider(context).primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            iconData,
            size: 36,
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, 'WidgetsPage');
        },
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _count = 20;
    });
    _refreshController?.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _count += 20;
    });
    _refreshController?.loadComplete();
  }

  @override
  Widget getBody(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: SmartRefresherViews.getHeader(context),
      footer: SmartRefresherViews.getFooter(context),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            // 巧妙的解决了去掉Tabbar，页面出现在状态栏的问题
            toolbarHeight: 0,
            // 控制折叠后的Tabbar固定在顶部
            pinned: true,
            // 固定的title
            backgroundColor: TLThemes.getProvider(context).primaryColor,
            // title: Text(I18n.getProvider(context).main),
            // actions: getActions(context),
            // floating: true,
            // 为true是AppBar会自动回弹
            // snap: true,
            /// SliverAppBar展开的高度
            expandedHeight: 60.0 * 2 + 10 + 10,
            // backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            // 跟随滑动的title
            flexibleSpace: FlexibleSpaceBar(
              // 背景消失的动画方式
              collapseMode: CollapseMode.parallax,
              background: Container(
                padding: EdgeInsets.only(
                    top: MediaQueryData.fromWindow(window).padding.top),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: TLThemes.getProvider(context).primaryColor,
                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              getIcon(Icons.cake_rounded),
                              getIcon(Icons.calculate_rounded),
                              getIcon(Icons.calendar_today),
                              getIcon(Icons.calendar_view_day),
                            ],
                          ),
                          Center(child: Text('SmartRefresher + CustomScrollView')),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getIcon(Icons.alarm_on),
                          getIcon(Icons.access_time_rounded),
                          getIcon(Icons.addchart),
                          getIcon(Icons.account_balance_wallet_outlined),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
              child: Container(
                decoration: BoxDecoration(
                    color: TLThemes.getProvider(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: getActions(context),
                ),
              ),
              size: Size(double.infinity, 60),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoSearchTextField(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: 60,
                  padding: EdgeInsets.all(16),
                  child: Text('food${index}'),
                );
              },
              childCount: _count,
            ),
          )
        ],
      ),
    );
  }
}
