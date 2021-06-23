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

  @override
  Widget getBody(BuildContext context) {
    print('刷新');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  themes.changeTheme(0);
                },
                child: Container(
                  width: 80,
                  height: 100,
                  child: Card(
                    color: Colors.blueAccent,
                    child: Offstage(
                      offstage: TLFlutterThemes.getProvider(context).themeIndex != 0,
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
                ),
              ),
              GestureDetector(
                onTap: (){
                  themes.changeTheme(1);
                },
                child: Container(
                  width: 80,
                  height: 100,
                  child: Card(
                    color: Colors.redAccent,
                    child: Offstage(
                      offstage: TLFlutterThemes.getProvider(context).themeIndex != 1,
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
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
