import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';

class LanguageSetting extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return LanguageSettingState();
  }
}

class LanguageSettingState extends BasePageTitleState {
  @override
  String getTitle() {
    return I18n.getProvider(context).languageSetting;
  }

  @override
  Widget getBody(BuildContext context) {
    print('刷新');
    return Container(
      child: Column(
        children: [
          ListTile(title: Text(I18n.getProvider(context).chinese), onTap: (){
            I18n.getProvider(context).setLocale(Locale('zh', 'CN'));
          }, selected: I18n.getProvider(context).locale.languageCode == 'zh',),
          Divider(height: 1,),
          ListTile(title: Text(I18n.getProvider(context).english), onTap: (){
            I18n.getProvider(context).setLocale(Locale('en'));
          }, selected: I18n.getProvider(context).locale.languageCode == 'en',)
        ],
      ),
    );
  }
}