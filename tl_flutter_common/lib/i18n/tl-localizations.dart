import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language/zh.dart';
import 'language/en.dart';

class I18n with ChangeNotifier {
  Locale _locale;

  I18n(this._locale);

  Locale get locale => _locale;
  String get main => $('main');
  String get news => $('news');
  String get mine => $('mine');
  String get themeSetting => $('themeSetting');
  String get languageSetting => $('languageSetting');
  String get chinese => $('chinese');
  String get english => $('english');

  void setLocale(Locale locale) {
    this._locale = locale;
    notifyListeners();
  }

  // 用于获取文字信息
  static I18n of(BuildContext context) {
    return Localizations.of(context, I18n);
  }

  // 用于发送事件刷新
  static I18n getProvider(BuildContext context, {bool listen = false}) {
    return Provider.of<I18n>(context, listen: listen);
  }

  $(String key){
    return _localizedValues[_locale.languageCode][key] ?? key ?? '';
  }
  static Map _localizedValues = {...en, ...zh};
}
