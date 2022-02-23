library biz_setting;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biz_setting/about/main.dart';
import 'package:flutter_biz_setting/language/main.dart';
import 'package:flutter_biz_setting/theme/main.dart';
import 'package:tl_flutter_common/main.dart';

part 'widget/widgets.dart';

final Map<String, WidgetBuilder> settingRoutes = {
  'ThemeSetting': (BuildContext context, {arguments}) => ThemeSetting(arguments),
  'LanguageSetting': (BuildContext context, {arguments}) => LanguageSetting(),
  'AboutUs': (BuildContext context, {arguments}) => AboutUs(),
  'WidgetsPage': (BuildContext context, { arguments }) => WidgetsPage(),
};
