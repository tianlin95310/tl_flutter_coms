import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TLThemes with ChangeNotifier {
  int _themeIndex = 0;

  ThemeMode _themeMode = ThemeMode.system;

  changeTheme(int theme) {
    _themeIndex = theme;
    notifyListeners();
  }

  get primaryColor => [Colors.cyanAccent, Colors.blueAccent, Colors.amberAccent, Colors.pinkAccent][_themeIndex];

  get themeIndex => _themeIndex;

  get themeMode => _themeMode;

  ThemeData get theme => [
        ThemeData(
          primaryColor: primaryColor,
          primaryColorDark: primaryColor,
          primaryColorLight: primaryColor,
          dividerColor: Colors.black12,
          indicatorColor: primaryColor,
          appBarTheme: AppBarTheme(
            backgroundColor: primaryColor
          )
          // brightness: Brightness.dark, // 影响界面内所有的文字颜色,控件的背景色，前景色
        ),
        ThemeData(
          primaryColor: primaryColor,
          primaryColorDark: primaryColor,
          primaryColorLight: primaryColor,
          dividerColor: Colors.black12,
          indicatorColor: primaryColor,
          // brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
                backgroundColor: primaryColor
            )
        ),
        ThemeData(
          primaryColor: primaryColor,
          primaryColorDark: primaryColor,
          primaryColorLight: primaryColor,
          dividerColor: Colors.black12,
          indicatorColor: primaryColor,
          // brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
                backgroundColor: primaryColor
            )
        ),
        ThemeData(
          primaryColor: primaryColor,
          primaryColorDark: primaryColor,
          primaryColorLight: primaryColor,
          dividerColor: Colors.black12,
          indicatorColor: primaryColor,
          // brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
                backgroundColor: primaryColor
            )
        )
      ][_themeIndex];

  ThemeData get darkTheme => [
    ThemeData.dark()
  ][0];

  // use this method get a object can refresh Style when listen = true, and notifyListeners is called
  static TLThemes getProvider(BuildContext context, {bool listen = true}) {
    return Provider.of<TLThemes>(context, listen: listen);
  }

  void updateMode(bool dark) {
    if (dark) {
      this._themeMode = ThemeMode.dark;
    } else {
      this._themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
