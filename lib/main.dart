import 'package:flutter/material.dart';
import 'package:tl_flutter_common/start/main.dart';

import 'package:flutter_biz_main/main.dart';
import 'package:flutter_biz_setting/main.dart';

final Map<String, WidgetBuilder> routes = {
  ...mainRoutes,
  ...settingRoutes
};

void main() async {
  // read app setting data
  runApp(MyApp(routes));
}

