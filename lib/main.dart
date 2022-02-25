import 'package:flutter/material.dart';
import 'package:tl_flutter_common/start/main.dart';

import 'package:flutter_biz_main/main.dart';
import 'package:flutter_biz_setting/main.dart';

final Map<String, WidgetBuilder> visitRoutes = {
  ...mainRoutes,
};

final Map<String, WidgetBuilder> authRoutes = {
  ...settingRoutes,
  ...commonRoutes
};

void main() async {
  // read app setting data
  runApp(MyApp(visitRoutes, authRoutes, {
    'theme': 0,
    'language': 'en-US'
  }));
}

