library biz_setting;

import 'package:flutter/material.dart';
import 'package:flutter_biz_setting/about/main.dart';
import 'package:flutter_biz_setting/language/main.dart';
import 'package:flutter_biz_setting/theme/main.dart';
import 'package:flutter_biz_setting/widget/AnimComp.dart';
import 'package:flutter_biz_setting/widget/CupertinoComp.dart';
import 'package:flutter_biz_setting/widget/GestureComp.dart';
import 'package:flutter_biz_setting/widget/LayoutComp.dart';
import 'package:flutter_biz_setting/widget/MaterialComp.dart';
import 'package:flutter_biz_setting/widget/SliverComp.dart';
import 'package:tl_flutter_common/main.dart';

part 'widget/widgets.dart';

final Map<String, WidgetBuilder> settingRoutes = {
  'ThemeSetting': (BuildContext context) => ThemeSetting(),
  'LanguageSetting': (BuildContext context) => LanguageSetting(),
  'AboutUs': (BuildContext context) => AboutUs(),
  'WidgetsPage': (BuildContext context) => WidgetsPage(),
  'LayoutComp': (BuildContext context) => LayoutComp(),

  'MaterialComp': (BuildContext context) => MaterialComp(),
  'CupertinoComp': (BuildContext context) => CupertinoComp(),
  'SliverComp': (BuildContext context) => SliverComp(),
  'AnimComp': (BuildContext context) => AnimComp(),
  'GestureComp': (BuildContext context) => GestureComp()
};
