
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:tl_flutter_common/main.dart';
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
      // indicatorColor: Colors.transparent,
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
              collapseMode: CollapseMode.parallax,
              background: Container(
                color: TLThemes.getProvider(context).primaryColor,
                child: Container(
                  height: 200,
                  color: TLThemes.getProvider(context).primaryColor,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Ff603918fa0ec08fa6443cb2657ee3d6d54fbdaf4.jpg&refer=http%3A%2F%2Fhiphotos.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627545167&t=484457509865f14437174d7959a23305',
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
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
          physics: BouncingScrollPhysics(),
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
