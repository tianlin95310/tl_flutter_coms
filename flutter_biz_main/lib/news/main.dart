import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return NewsPageState();
  }
}

class NewsPageState extends BasePageTitleState {
  RefreshController _refreshController;

  List news;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    news = [
      '外交部就美再借新冠病毒溯源对华施压等答问',
      '高考成绩要“放榜”了，多地发布重要消息，这些信息不可不知',
      '外交部就美再借新冠病毒溯源对华施压等答问',
      '高考成绩要“放榜”了，多地发布重要消息，这些信息不可不知',
      '外交部就美再借新冠病毒溯源对华施压等答问',
      '高考成绩要“放榜”了，多地发布重要消息，这些信息不可不知',
      '外交部就美再借新冠病毒溯源对华施压等答问',
      '高考成绩要“放榜”了，多地发布重要消息，这些信息不可不知',
      '外交部就美再借新冠病毒溯源对华施压等答问',
      '高考成绩要“放榜”了，多地发布重要消息，这些信息不可不知',
      '外交部就美再借新冠病毒溯源对华施压等答问',
      '高考成绩要“放榜”了，多地发布重要消息，这些信息不可不知',
    ];
  }

  @override
  String getTitle(BuildContext context) {
    return I18n.getProvider(context).news;
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
      child: ListView.separated(
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
}
