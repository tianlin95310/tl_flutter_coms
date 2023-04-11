import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';
import 'package:provider/provider.dart';

class LanguageSetting extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return LanguageSettingState();
  }
}

class LanguageSettingState extends BasePageTitleState {
  @override
  String getTitle(BuildContext context) {
    return I18n.of(context).languageSetting;
  }

  @override
  Widget getBody(BuildContext context) {
    print('LanguageSetting 刷新');
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(I18n.of(context).chinese),
            onTap: () {
              I18n.getProvider(context).setLocale(Locale('zh', 'CN'));
            },
            selected: I18n.of(context).locale.languageCode == 'zh',
          ),
          Divider(
            height: 1,
          ),
          // ListTile(
          //   title: Text(I18n.of(context).english),
          //   onTap: () {
          //     I18n.getProvider(context).setLocale(Locale('en'));
          //   },
          //   selected: I18n.of(context).locale.languageCode == 'en',
          // ),
          Consumer(
            builder: (BuildContext context, I18n localizations, Widget child) {
              return ListTile(
                title: Text(I18n.of(context).english),
                onTap: () {
                  localizations.setLocale(Locale('en'));
                },
                selected: I18n.of(context).locale.languageCode == 'en',
              );
            },
          )
        ],
      ),
    );
  }
}
