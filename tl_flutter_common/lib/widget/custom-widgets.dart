import 'package:tl_flutter_common/main.dart';
import 'package:flutter/material.dart';

class CustomWidgets extends BaseStatefulWidget {
  State getState() {
    return _CustomWidgetsState();
  }
}

class _CustomWidgetsState extends BasePageTitleState<CustomWidgets> {
  String getTitle(BuildContext context) {
    return I18n.of(context).custom_widget;
  }

  Widget getBody(BuildContext context) {
    return Container();
  }
}
