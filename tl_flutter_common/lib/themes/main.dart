import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TLThemes with ChangeNotifier {
  static int _themeIndex = 0;

  changeTheme(int theme) {
    _themeIndex = theme;
    notifyListeners();
  }

  get primaryColor => [Colors.cyanAccent, Colors.redAccent][_themeIndex];

  // use this method get a object can refresh Style when listen = true, and notifyListeners is called
  static TLThemes getProvider(BuildContext context, {bool listen = true}) {
    return Provider.of<TLThemes>(context, listen: listen);
  }

  get themeIndex => _themeIndex;

  ThemeData get theme => [
        ThemeData(
          primaryColor: primaryColor,
          primaryColorDark: primaryColor,
          primaryColorLight: primaryColor,
          dividerColor: primaryColor,
          indicatorColor: primaryColor,
          // brightness: Brightness.dark, // 影响界面内所有的文字颜色,控件的背景色，前景色
        ),
        ThemeData(
          primaryColor: primaryColor,
          primaryColorDark: primaryColor,
          primaryColorLight: primaryColor,
          dividerColor: primaryColor,
            indicatorColor: primaryColor,
          // brightness: Brightness.dark,
        )
      ][_themeIndex];

  Color get textColor => [Colors.cyanAccent, Colors.redAccent][_themeIndex];
}
