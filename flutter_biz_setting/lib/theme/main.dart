import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';

class ThemeSetting extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return ThemeSettingState();
  }
}

class ThemeSettingState extends BasePageTitleState {
  @override
  String getTitle(BuildContext context) {
    return I18n.getProvider(context).themeSetting;
  }

  Widget getItem(Color themeColor, int themeIndex) {
    return Container(
      width: 80,
      height: 100,
      child: Card(
        color: themeColor,
        child: Offstage(
          offstage: TLThemes.getProvider(context).themeIndex != themeIndex,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    print('ThemeSetting 刷新');
    // 通过此种方式也能获取到参数，但是取值时机存在限制，需要context
    print(ModalRoute.of(context).settings.arguments);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  TLThemes.getProvider(context, listen: false).changeTheme(0);
                  // themes.changeTheme(0);
                },
                child: getItem(Colors.cyanAccent, 0),
              ),
              GestureDetector(
                onTap: () {
                  TLThemes.getProvider(context, listen: false).changeTheme(1);
                  // themes.changeTheme(1);
                },
                child: getItem(Colors.blueAccent, 1),
              ),
              GestureDetector(
                onTap: () {
                  TLThemes.getProvider(context, listen: false).changeTheme(2);
                  // themes.changeTheme(1);
                },
                child: getItem(Colors.amberAccent, 2),
              ),
              GestureDetector(
                onTap: () {
                  TLThemes.getProvider(context, listen: false).changeTheme(3);
                  // themes.changeTheme(1);
                },
                child: getItem(Colors.pinkAccent, 3),
              ),
            ],
          )
        ],
      ),
    );
  }
}
