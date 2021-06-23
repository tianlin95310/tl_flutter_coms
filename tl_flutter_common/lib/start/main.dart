import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tl_flutter_common/main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tl_flutter_common/i18n/tl-locale-delegate.dart';
// 主题常量
final TLFlutterThemes themes = TLFlutterThemes();

class MyApp extends StatelessWidget {
  final Map<String, WidgetBuilder> routes;

  MyApp(this.routes);

  @override
  Widget build(BuildContext context) {
    print('MyApp build');
    final SystemUiOverlayStyle _style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(_style);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themes),
        ChangeNotifierProvider(create: (BuildContext context){
          return I18n(Locale("zh", 'CN'));
        },)
      ],
      builder: (BuildContext context, Widget child){
        print('MultiProvider build');
        return Consumer<I18n>(
          builder: (BuildContext ctx, I18n localizations, Widget child){
            print('---TlLocalizations Consumed---');
            return MaterialApp(
              title: 'Flutter Demo',
              theme: TLFlutterThemes.getProvider(context).theme,
              initialRoute: 'home',
              routes: routes,
              // 未注册的动态路由
              onGenerateRoute: (RouteSettings settings) {
                print('---onGenerateRoute---');
                print(settings.toString());
                return CupertinoPageRoute(
                  settings: settings,
                );
              },
              onUnknownRoute: (RouteSettings settings) {
                print('---onUnknownRoute---');
                print(settings.toString());
                return CupertinoPageRoute(
                  settings: settings,
                );
              },
              locale: localizations.locale,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                TlLocalizationsDelegate.delegate,
                RefreshLocalizations.delegate,
              ],
              localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales){
                print('---localeResolutionCallback---');
                print(locale?.languageCode);
                if (locale == null) {
                  return locale;
                }
                if (locale?.languageCode == 'zh') {
                  return Locale('zh', 'CN');
                } else {
                  return locale;
                }
              },
              supportedLocales: [
                Locale("en"),
                Locale("zh")
              ],
            );
          },
        );
      },
    );
  }
}
