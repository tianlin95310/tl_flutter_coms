import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  @override
  State createState() {
    return getState();
  }

  State getState();

  BaseStatefulWidget({Key key}) : super(key: key);
}

// 基本的StatefulWidget State
abstract class BaseState<T extends BaseStatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return getBody(context);
  }

  Widget getBody(BuildContext context);

  @override
  void initState();
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
      brightness: Brightness.dark,
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
                  'Loading...',
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
      brightness: Brightness.dark,
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
            child: Center(
              child: Text(
                'Loading...',
                style: TextStyle(fontSize: 32),
              ),
            ),
          );
        }
      },
    );
  }

  Widget getContent(BuildContext context);
}
