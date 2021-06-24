import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';

class NotFoundPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return NotFoundState();
  }
}

class NotFoundState extends BasePageTitleState {
  @override
  String getTitle(BuildContext context) {
    return "错误页面";
  }
  @override
  Widget getBody(BuildContext context) {
    return Center(
      child: Text('页面错误，你访问的页面不存在'),
    );
  }
}
