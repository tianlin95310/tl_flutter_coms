import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';

class SettingPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return SettingPageState();
  }
}

class SettingPageState extends BasePageTitleState {

  @override
  String getTitle(BuildContext context) {
    return I18n.getProvider(context).mine;
  }

  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(I18n.getProvider(context).themeSetting),
          onTap: () {
            Navigator.pushNamed(context, 'ThemeSetting', arguments: {'id': 1});
          },
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          title: Text(I18n.getProvider(context).languageSetting),
          onTap: () {
            Navigator.pushNamed(context, 'LanguageSetting');
          },
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          title: Text('关于我们'),
          onTap: () {
            Navigator.pushNamed(context, 'AboutUs');
          },
        ),
        Divider(
          height: 1,
        ),
        ListTile(
          title: Text('页面走丢了'),
          onTap: () {
            Navigator.pushNamed(context, 'unknown');
          },
        )
      ],
    );
  }
}
