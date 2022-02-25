import 'package:cached_network_image/cached_network_image.dart';
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
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // 控制折叠后的Tabbar固定在顶部
              pinned: true,
              // 固定的title
              // title: Text(I18n.getProvider(context).mine),
              backgroundColor: TLThemes.getProvider(context).primaryColor,
              floating: true,
              // 为true是AppBar会自动回弹
              // snap: true,
              /// SliverAppBar展开的高度
              expandedHeight: 200,
              leading: GestureDetector(
                onTap: (){},
                child: Icon(Icons.manage_search),
              ),
              flexibleSpace: FlexibleSpaceBar(
                // 背景消失的动画方式
                collapseMode: CollapseMode.none,
                titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 16),
                // 跟随滑动的title
                title: Text(I18n.getProvider(context).mine),
                background: Container(
                  color: TLThemes.getProvider(context).primaryColor,
                  child: Container(
                    height: 200,
                    color: TLThemes.getProvider(context).primaryColor,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Ff603918fa0ec08fa6443cb2657ee3d6d54fbdaf4.jpg&refer=http%3A%2F%2Fhiphotos.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627545167&t=484457509865f14437174d7959a23305',
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
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
        ));
  }
}
