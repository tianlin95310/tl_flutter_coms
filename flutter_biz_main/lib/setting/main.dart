import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';

class SettingPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return SettingPageState();
  }
}

class SettingPageState extends BaseState {
  @override
  Widget getBody(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(title: Text(I18n.getProvider(context).themeSetting), onTap: (){
            Navigator.pushNamed(context, 'ThemeSetting', arguments: {'id': 1});
          },),
          Divider(height: 1,),
          ListTile(title: Text(I18n.getProvider(context).languageSetting), onTap: (){
            Navigator.pushNamed(context, 'LanguageSetting');
          },)
        ],
      ),
    );
  }

}