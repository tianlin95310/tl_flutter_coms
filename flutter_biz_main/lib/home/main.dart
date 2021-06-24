import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';

class HomePage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return HomePageState();
  }
}

class HomePageState extends BasePageTitleState {

  @override
  String getTitle(BuildContext context) {
    return I18n.getProvider(context).main;
  }

  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
