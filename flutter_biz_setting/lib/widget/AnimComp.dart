import 'package:flutter/material.dart';
import 'package:tl_flutter_common/base/base-widget.dart';

class AnimComp extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return AnimCompState();
  }
}

class AnimCompState extends BasePageTitleState
    with SingleTickerProviderStateMixin {
  final _url =
      'https://img2.baidu.com/it/u=3202947311,1179654885&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500';

  double _width = 100;

  double _opacity = 0.1;

  Animation<double> _op;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3),);

    _controller.addListener(() {
      print('_controller.value');
      print(_controller.value);
    });
    _controller.addStatusListener((status) {
      print('_controller.status');
      print(status);
    });
    // 补间动画
    _op = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _op.addListener(() {
      print('_op.value');
      print(_op.value);
    });
    _op.addStatusListener((status) {
      print('_op.status');
      print(status);
    });
    _controller.forward();
    print(_controller.view);
  }

  void onClick() {
    this._width += 50;
    this._opacity += 0.1;
    if (this._width >= 300) {
      this._width = 100;
    }
    if (this._opacity >= 1) {
      this._opacity = 0.1;
    }
    setState(() {});
  }

  @override
  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
                onTap: onClick,
                child: AnimatedContainer(
                  width: _width,
                  height: 42,
                  duration: Duration(milliseconds: 100),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(_width / 2)))),
                  // color: Colors.lightBlue,
                  child: ElevatedButton(
                    child: Text('ElevatedButton'),
                    onPressed: onClick,
                  ),
                )),
            Dismissible(
              confirmDismiss: (DismissDirection d)async {
                return Future.value(true);
              },
                onDismissed: (DismissDirection d) {
                },
                key: GlobalKey(),
                child: Container(
                    height: 100,
                    width: 150,
                    child: Card(
                      color: Colors.black45,
                    ))),
            FadeTransition(
              opacity: _controller.view,
              child: Container(
                color: Colors.lightBlue,
                width: 100,
                height: 100,
              ),
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 200),
              child: Container(
                color: Colors.lightBlue,
                width: 100,
                height: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
