import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TLThemes with ChangeNotifier{
  static int _themeIndex = 0;

  changeTheme(int theme){
    _themeIndex = theme;
    notifyListeners();
  }

  get primaryColor => [Colors.blueAccent, Colors.redAccent][_themeIndex];

  // use this method get a object can refresh Style when listen = true, and notifyListeners is called
  static TLThemes getProvider(BuildContext context, {bool listen = true}){
    return Provider.of<TLThemes>(context, listen: listen);
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