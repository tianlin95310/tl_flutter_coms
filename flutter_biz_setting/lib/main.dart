import 'package:flutter/material.dart';
import 'theme/main.dart';
import 'language/main.dart';
final Map<String, WidgetBuilder> settingRoutes = {
  'ThemeSetting': (BuildContext context, { arguments }) => ThemeSetting(),
  'LanguageSetting': (BuildContext context, {arguments} ) => LanguageSetting()
};

