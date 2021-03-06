library biz_setting;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biz_setting/about/main.dart';
import 'package:flutter_biz_setting/language/main.dart';
import 'package:flutter_biz_setting/theme/main.dart';
import 'package:tl_flutter_common/main.dart';

part 'widget/widgets.dart';

final Map<String, WidgetBuilder> settingRoutes = {
  'ThemeSetting': (BuildContext context) => ThemeSetting(),
  'LanguageSetting': (BuildContext context) => LanguageSetting(),
  'AboutUs': (BuildContext context) => AboutUs(),
  'WidgetsPage': (BuildContext context) => WidgetsPage(),
};
