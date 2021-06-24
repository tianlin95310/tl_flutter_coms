import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TLFlutterThemes with ChangeNotifier{
  static int _themeIndex = 0;

  changeTheme(int theme){
    _themeIndex = theme;
    notifyListeners();
  }

  // use this method get a object can refresh Style when listen = true, and notifyListeners is called
  static TLFlutterThemes getProvider(BuildContext context, {bool listen = true}){
    return Provider.of<TLFlutterThemes>(context, listen: listen);
  }

  get themeIndex => _themeIndex;

  ThemeData get theme => [
    ThemeData(
      primaryColor: Colors.blueAccent,
    ),
    ThemeData(
      primaryColor: Colors.redAccent,
    )
  ][_themeIndex];

  Color get textColor => [
    Colors.blueAccent,
    Colors.redAccent
  ][_themeIndex];

}