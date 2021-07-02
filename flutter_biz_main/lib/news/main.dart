import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tl_flutter_common/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../components.dart';

class NewsPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return NewsPageState();
  }
}

class NewsPageState extends BaseState with SingleTickerProviderStateMixin {
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
      labelColor: Colors.white,
      tabs: tabs.map((e) => Tab(text: e)).toList(),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return NestedScrollView(
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            // 巧妙的解决了去掉Tabbar，页面出现在状态栏的问题
            toolbarHeight: 0,
            // 控制折叠后的Tabbar固定在顶部
            pinned: true,
            // 固定的title
            // title: Text(I18n.getProvider(context).news),
            brightness: Brightness.dark,
            // floating: true,
            // 为true是AppBar会自动回弹
            // snap: true,
            /// SliverAppBar展开的高度
            expandedHeight: 200,
            shadowColor: Colors.transparent,
            // 跟随滑动的title
            flexibleSpace: FlexibleSpaceBar(
              // 背景消失的动画方式
              collapseMode: CollapseMode.none,
              background: Container(
                color: TLThemes.getProvider(context).primaryColor,
                child: Container(
                  height: 200,
                  // android:usesCleartextTraffic="true"
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: 'http://pic1.win4000.com/wallpaper/2019-12-16/5df6ef1080699.jpg',
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            bottom: getTabBar(),
          ),

          // SliverPersistentHeader(
          //   pinned: true,
          //   delegate: MySliverPersistentHeaderDelegate(
          //       child: Container(
          //         child: getTabBar(),
          //         decoration: BoxDecoration(color: TLThemes.getProvider(context).primaryColor),
          //         padding: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
          //       ),
          //       size: Size(double.infinity, 56 + MediaQueryData.fromWindow(window).padding.top)),
          // ),
        ];
      },
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: tabs.map((String key) {
          return NewsPageList(key);
        }).toList(),
      ),
    );
  }
}

class NewsPageList extends BaseStatefulWidget {
  final String name;

  NewsPageList(this.name);

  @override
  State<StatefulWidget> getState() {
    return NewsPageListState();
  }
}

// 保留各tab的状态
class NewsPageListState extends BaseFutureStateKeepAlive<NewsPageList> {
  List news;
  RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    news = [];
    super.initState();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    news = news.sublist(0, 12);
    setState(() {});
    _refreshController?.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {
    await Future.delayed(Duration(seconds: 1));
    news.addAll(news.sublist(0, 12));
    setState(() {});
    _refreshController?.loadComplete();
  }

  @override
  Widget getContent(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: SmartRefresherViews.getHeader(context),
      footer: SmartRefresherViews.getFooter(context),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: news.length,
        itemBuilder: (BuildContext context, int index) {
          var item = news[index];
          return Container(
            height: 60,
            padding: EdgeInsets.all(8),
            child: Text(item ?? ''),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF5F5F5),
          );
        },
      ),
    );
  }

  @override
  Future loadData() async {
    for (int i = 0; i < 12; i++) {
      news.add('${widget.name}${i + 1}');
    }
    await Future.delayed(Duration(seconds: 1));
  }
}
