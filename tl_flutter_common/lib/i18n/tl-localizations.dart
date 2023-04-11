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
  String get product => $('product');

  String get cart => $('cart');

  String get custom_widget => $('custom_widget');

  String get appTitle => $('custom_widget');

  void setLocale(Locale locale) {
    this._locale = locale;
    notifyListeners();
  }

  // 用于获取文字信息
  static I18n of(BuildContext context) {
    return Localizations.of(context, I18n);
  }

//  用于获取I18n
//  InheritedWidget有个默认的约定：如果状态是希望暴露出的，应当提供一个 “of” 静态方法来获取其对象，开发者便可直接通过该方法来获取。
//  获取最近的context上下文对象
//  这个静态方法可以获取widget树中最近的Provider<T>，并且返回它的值。如果listen为true,那么随后value发生的变化会触发State.build和
//  State.didChangeDependencies. 如果需要在initState中调用Provider.of或者如下调用Provider的create方法时，需要设置listen为false：
  static I18n getProvider(BuildContext context, {bool listen = false}) {
    return Provider.of<I18n>(context, listen: listen);
  }

  $(String key){
    return _localizedValues[_locale.languageCode][key] ?? key ?? '';
  }
  static Map _localizedValues = {...en, ...zh};
}
