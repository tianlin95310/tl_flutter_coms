import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tl_flutter_common/main.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;
import 'package:loading_more_list/loading_more_list.dart';

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
    return way(context);
  }

  Widget way(BuildContext context) {
    return extended.NestedScrollView(
      pinnedHeaderSliverHeightBuilder: () {
        return MediaQuery.of(context).padding.top + kToolbarHeight;
      },
      innerScrollPositionKeyBuilder: () {
        return Key(tabs[_tabController.index]);
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
            expandedHeight: 200,
            shadowColor: Colors.transparent,
            // 跟随滑动的title
            flexibleSpace: FlexibleSpaceBar(
              // 背景消失的动画方式
              collapseMode: CollapseMode.pin,
              background: Container(
                color: TLThemes.getProvider(context).primaryColor,
                child: Container(
                  height: 200,
                  color: TLThemes.getProvider(context).primaryColor,
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
          return NewsItem(key);
        }).toList(),
      ),
    );
  }
}

class NewsItem extends BaseStatefulWidget {
  final String name;

  NewsItem(this.name);

  @override
  State<StatefulWidget> getState() {
    return NewsItemState();
  }
}

class LoadingMoreSource extends LoadingMoreBase<int> {
  @override
  Future<bool> loadData([bool isloadMoreAction = false]) {
    print('---loadData---' + isloadMoreAction.toString());
    return Future<bool>.delayed(const Duration(seconds: 1), () {
      int index = this.length;
      for (int i = 0; i < 10; i++) {
        add(index + i);
      }
      return true;
    });
  }
}

class NewsItemState extends BaseState<NewsItem> {
  LoadingMoreBase source;

  @override
  void initState() {
    source = LoadingMoreSource();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget getBody(BuildContext context) {
    return extended.NestedScrollViewInnerScrollPositionKeyWidget(
      Key(widget.name),
      LoadingMoreList<int>(
        ListConfig<int>(
            itemBuilder: (BuildContext c, int item, int index) {
              var item = source[index];
              return Card(
                color: Colors.white,
                margin: EdgeInsets.all(16),
                child: Container(
                  height: 80,
                  child: Text(widget.name + '$item'),
                  padding: EdgeInsets.all(16),
                ),
              );
            },
            sourceList: source,
            indicatorBuilder: (BuildContext context, IndicatorStatus status) {
              return Container(
                height: 60,
                child: Center(child: Text('loading...')),
              );
            }),
      ),
    );
  }
}
