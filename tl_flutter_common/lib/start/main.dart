import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tl_flutter_common/main.dart';
import 'package:tl_flutter_common/widget/image-cut-view.dart';
import 'package:tl_flutter_common/widget/page-not-found.dart';
import 'package:tl_flutter_common/widget/custom-widgets.dart';

final Map<String, WidgetBuilder> commonRoutes = {
  'NotFoundPage': (BuildContext context) => NotFoundPage(),
  'ImageCutView': (BuildContext context, { arguments }) => ImageCutView(arguments: arguments),
  'CustomWidgets': (BuildContext context) => CustomWidgets()
};

class MyApp extends StatelessWidget {
  final Map<String, WidgetBuilder> visitRoutes;
  final Map<String, WidgetBuilder> authRoutes;

  final Map config;

  MyApp(this.visitRoutes, this.authRoutes, this.config);

  @override
  Widget build(BuildContext context) {
    print('MyApp build');
    int theme = config['theme'] ?? 1;
    String language = config['language'] ?? 'zh-CN';

    TLThemes themes = TLThemes();
    themes.changeTheme(theme);
    I18n i18n = I18n(Locale("zh", 'CN'));
    if (language == 'zh-CN') {
      i18n = I18n(Locale("zh", 'CN'));
    } else if (language == 'en-US') {
      i18n = I18n(Locale("en", 'US'));
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themes),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return i18n;
          },
        )
      ],
      builder: (BuildContext context, Widget child) {
        print('MultiProvider build');
        return Consumer<I18n>(
          builder: (BuildContext ctx, I18n localizations, Widget child) {
            print('---TlLocalizations Consumed---');
            return MaterialApp(
              title: 'Flutter Demo',
              theme: TLThemes.getProvider(context).theme,
              initialRoute: 'home',
              routes: visitRoutes,
              // app进入任务列表菜单后的标题
              onGenerateTitle: (BuildContext context) {
                return 'Tl Flutter Comps';
              },
              // 未注册的动态路由
              onGenerateRoute: (RouteSettings settings) {
                print('---onGenerateRoute---');
                print(settings?.toString());
                String routeName = settings.name;
                Function builder = authRoutes[routeName];
                if (builder != null) {
                  if (settings.arguments != null) {
                    return CupertinoPageRoute(
                      settings: settings,
                      builder: (BuildContext context){
                        return builder(context, arguments: settings.arguments);
                      },
                    );
                  } else {
                    return CupertinoPageRoute(
                      settings: settings,
                      builder: builder,
                    );
                  }
                } else {
                  // when run this, it will call onUnknownRoute later
                  return null;
                }
              },
              onUnknownRoute: (RouteSettings settings) {
                print('---onUnknownRoute---');
                print(settings.toString());
                WidgetBuilder builder = authRoutes['NotFoundPage'];
                return CupertinoPageRoute(settings: settings, builder: builder);
              },
              locale: localizations.locale,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                TlLocalizationsDelegate.delegate,
                RefreshLocalizations.delegate,
              ],
              localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
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
              supportedLocales: [Locale("en"), Locale("zh")],
            );
          },
        );
      },
    );
  }
}
