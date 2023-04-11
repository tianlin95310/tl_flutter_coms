import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tl_flutter_common/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tl_flutter_common/utils/image-convert-utils.dart';
import 'dart:ui' as ui;

class SettingPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return SettingPageState();
  }
}

class SettingPageState extends BaseState {
  var img;

  @override
  Widget getBody(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // 控制折叠后的Tabbar固定在顶部
              pinned: true,
              // 固定的title
              backgroundColor: TLThemes.getProvider(context).primaryColor,
              floating: true,
              // 为true是AppBar会自动回弹
              // snap: true,
              /// SliverAppBar展开的高度
              expandedHeight: 200,
              title: Text('Title1'),
              flexibleSpace: FlexibleSpaceBar(
                // 背景消失的动画方式
                collapseMode: CollapseMode.parallax,
                title: Text(
                  'Title2',
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 16),
                // 跟随滑动的title
                background: Container(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 224,
                        color: TLThemes.getProvider(context).primaryColor,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Ff603918fa0ec08fa6443cb2657ee3d6d54fbdaf4.jpg&refer=http%3A%2F%2Fhiphotos.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627545167&t=484457509865f14437174d7959a23305',
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        child: GestureDetector(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            XFile image = await _picker.pickImage(source: ImageSource.gallery);
                            if (image == null) {
                              return;
                            }
                            ui.Image img = await Navigator.pushNamed<dynamic>(
                              context,
                              'ImageCutView',
                              arguments: {
                                'img': await ImageUtils.loadByXFile(image),
                                'path': image.path,
                              },
                            );
                            ByteData byteData = await img.toByteData(format: ui.ImageByteFormat.png);
                            this.img = byteData.buffer.asUint8List();
                            setState(() {});
                          },
                          child: this.img == null
                              ? Center(
                                  child: Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 50,
                                ))
                              : Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: MemoryImage(this.img),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
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
              title: Text(I18n.of(context).themeSetting),
              onTap: () {
                Navigator.pushNamed(context, 'ThemeSetting');
              },
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              title: Text(I18n.of(context).languageSetting),
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
            ),
            Divider(
              height: 1,
            ),
            ListTile(
              title: Text('Canvas自定义控件'),
              onTap: () {
                Navigator.pushNamed(context, 'CustomWidgets');
              },
            )
          ],
        ));
  }
}
