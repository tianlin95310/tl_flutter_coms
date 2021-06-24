import 'package:flutter/material.dart';
import 'package:flutter_biz_setting/about/main.dart';
import 'package:flutter_biz_setting/language/main.dart';
import 'package:flutter_biz_setting/theme/main.dart';

final Map<String, WidgetBuilder> settingRoutes = {
  'ThemeSetting': (BuildContext context, {arguments}) => ThemeSetting(arguments),
  'LanguageSetting': (BuildContext context, {arguments}) => LanguageSetting(),
  'AboutUs': (BuildContext context, {arguments}) => AboutUs()
};
