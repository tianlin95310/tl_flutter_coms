import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tl_flutter_common/main.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  @override
  State createState() {
    return getState();
  }

  State getState();

  BaseStatefulWidget({Key key}) : super(key: key);
}

// 基本的StatefulWidget State, no Scaffold
abstract class BaseState<T extends BaseStatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return getBody(context);
  }

  Widget getBody(BuildContext context);

  @override
  void initState();

  @override
  bool get wantKeepAlive => false;
}

// 带有AppBar的state
abstract class BasePageTitleState<T extends BaseStatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context);

  @override
  void initState();

  AppBar getAppbar(BuildContext context) {
    return AppBar(
      title: Text(getTitle(context)),
      actions: getActions(context),
      backgroundColor: TLThemes.getProvider(context).primaryColor,
    );
  }

  String getTitle(BuildContext context) {
    return '标题';
  }

  List<Widget> getActions(BuildContext context) {
    return [];
  }
}

// 带有AppBar的异步加载state
abstract class BasePageTitleFutureState<T extends BaseStatefulWidget> extends State<T> {

  Future _future;

  @override
  void initState() {
    super.initState();
    _future = loadData();
  }

  // 加载网络数据
  Future loadData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context),
      body: FutureBuilder(
        future: _future,
        initialData: null,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.done) {
            return getBody(context);
          } else {
            return Container(
              child: Center(
                child: Text(
                  'loading...',
                  style: TextStyle(fontSize: 32),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget getBody(BuildContext context);

  AppBar getAppbar(BuildContext context) {
    return AppBar(
      title: Text(getTitle(context)),
      actions: getActions(context),
      backgroundColor: TLThemes.getProvider(context).primaryColor,
    );
  }

  String getTitle(BuildContext context) {
    return '标题';
  }

  List<Widget> getActions(BuildContext context) {
    return [];
  }
}

// 异步加载的局部界面的State
abstract class BaseFutureState<T extends BaseStatefulWidget> extends State<T> {
  Future _future;

  @override
  void initState() {
    super.initState();
    _future = loadData();
  }

  Future loadData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      initialData: null,
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.done) {
          return getContent(context);
        } else {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            alignment: loadingPosition(),
            child: Text(
              'loading...',
            ),
          );
        }
      },
    );
  }

  Alignment loadingPosition(){
    return Alignment.centerLeft;
  }

  Widget getContent(BuildContext context);
}
