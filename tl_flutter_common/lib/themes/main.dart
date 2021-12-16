import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TLThemes with ChangeNotifier {
  static int _themeIndex = 0;

  changeTheme(int theme) {
    _themeIndex = theme;
    notifyListeners();
  }

  get primaryColor => [Colors.blueAccent, Colors.redAccent][_themeIndex];

  // use this method get a object can refresh Style when listen = true, and notifyListeners is called
  static TLThemes getProvider(BuildContext context, {bool listen = true}) {
    return Provider.of<TLThemes>(context, listen: listen);
  }

  get themeIndex => _themeIndex;

  ThemeData get theme => [
        ThemeData(
          primaryColor: Colors.blueAccent,
          primaryColorDark: Colors.blueAccent,
          primaryColorLight: Colors.blueAccent,
          colorScheme: ColorScheme(
            primary: Colors.blueAccent,
            primaryVariant: Colors.blueAccent.shade400,
            secondary: Colors.blueAccent.shade200,
            secondaryVariant: Colors.blueAccent.shade100,
            surface: Colors.white,
            background: Colors.blueAccent.shade50,
          ),
        ),
        ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.redAccent,
          primaryColorLight: Colors.redAccent,
          colorScheme: ColorScheme(
            primary: Colors.redAccent,
            primaryVariant: Colors.redAccent.shade400,
            secondary: Colors.redAccent.shade200,
            secondaryVariant: Colors.redAccent.shade100,
            surface: Colors.white,
            background: Colors.blueAccent.shade50,
          ),
          splashColor: Colors.redAccent.shade200
        )
      ][_themeIndex];

  Color get textColor => [Colors.blueAccent, Colors.redAccent][_themeIndex];
}
