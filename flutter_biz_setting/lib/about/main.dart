import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';

class AboutUs extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return LanguageSettingState();
  }
}

class LanguageSettingState extends BasePageTitleFutureState {
  @override
  String getTitle(BuildContext context) {
    return '关于';
  }
  
  @override
  Future loadData() async{
    await Future.delayed(Duration(seconds: 1));
  }
  @override
  Widget getBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Text('Author: 田林'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Text('Github: https://github.com/tianlin95310'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Text('Email: li.tian.haha@foxmail.com'),
            ),
          ],
        ),
      ),
    );
  }
}