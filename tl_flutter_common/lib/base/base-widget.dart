import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  @override
  State createState() {
    return getState();
  }

  State getState();

  BaseStatefulWidget({Key key}) : super(key: key);
}

abstract class BasePageTitleState<T extends BaseStatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: getBody(context),
    );
  }
  PreferredSizeWidget getAppbar() {
    return AppBar(
      title: Text(getTitle()),
      brightness: Brightness.dark,
    );
  }

  String getTitle();

  Widget getBody(BuildContext context);

  @override
  void initState();
}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return getBody(context);
  }

  Widget getBody(BuildContext context);

  @override
  void initState();
}

// 异步加载的State
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
        });
  }

  Widget getBody(BuildContext context);
}
