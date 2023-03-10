import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tl_flutter_common/base/base-widget.dart';

class LayoutComp extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return LayoutCompState();
  }
}

class LayoutCompState extends BasePageTitleState {

  final _url = 'https://img2.baidu.com/it/u=3202947311,1179654885&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500';
  @override
  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              FlutterLogo(),
              Expanded(flex: 1, child: SizedBox(child: Text('我占1'))),
              Expanded(flex: 2, child: SizedBox(child: Text('我占2')))
            ],
          ),
          Card(
            color: Colors.greenAccent,
            child: SizedBox(
              width: 100,
              height: 100,
              child: Text('Card组件 with SizedBox'),
            ),
          ),
          Container(
            color: Colors.amberAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Container居中 with Padding'),
            ),
          ),
          Divider(
            indent: 12,
            endIndent: 24,
          ),
          Container(
              width: 250,
              height: 120,
              color: Colors.deepPurple,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text('Align in a Container'),
              )),
          Container(
            color: Colors.cyan,
            child: Align(
              alignment: Alignment.bottomCenter,
              widthFactor: 2,
              heightFactor: 4,
              child: Card(
                child: SizedBox(
                  width: 150,
                  height: 60,
                  child: Text('Align widthFactor = 2 heightFactor = 4'),
                ),
                color: Colors.cyanAccent,
                margin: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: AspectRatio(
              aspectRatio: 16.0 / 9,
              child: Container(
                width: MediaQuery.of(context).size.width, // make no sense
                child: Card(
                  color: Colors.yellow,
                  child: Text('AspectRatio 16.0 / 9.0 with SizedBox'),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Baseline(baseline: 0, baselineType: TextBaseline.ideographic, child: Row(children: [
                Text('AAA', style: TextStyle(fontSize: 14),),
                Text('AAA', style: TextStyle(fontSize: 16),),
                Text('AAA', style: TextStyle(fontSize: 18),),
                Text('AAA', style: TextStyle(fontSize: 20),),
              ],),),
            ],
          ),
          Divider(),
          Row(
            children: [
              Baseline(baseline: 0, baselineType: TextBaseline.ideographic, child: Text('AAA', style: TextStyle(fontSize: 14),),),
              Baseline(baseline: 0, baselineType: TextBaseline.ideographic, child: Text('AAA', style: TextStyle(fontSize: 16),),),
              Baseline(baseline: 0, baselineType: TextBaseline.ideographic, child: Text('AAA', style: TextStyle(fontSize: 18),),),
              Baseline(baseline: 0, baselineType: TextBaseline.ideographic, child: Text('AAA', style: TextStyle(fontSize: 20),),),
            ],
          ),
          Container(
            width: 400,
            height: 200,
            color: Colors.lightBlueAccent,
            child: Center(
              child: SizedBox(
                width: 200,
                child: Image.network(_url),
              ),
            ),
          ),
          ConstrainedBox(constraints: BoxConstraints(maxHeight: 50), child: Text('床前明月光\n疑是地上霜'),),
          ConstrainedBox(constraints: BoxConstraints(maxHeight: 30), child: Text('床前明月光\n疑是地上霜'),),
          Card(color: Colors.amberAccent, child: CustomSingleChildLayout(delegate: MySingleChildLayoutDelegate(), child: Text('CustomSingleChildLayout'),)),

          SizedBox(width: 200, height: 200, child: FittedBox(fit: BoxFit.fitWidth, child: Stack(
            children: [
              Image.network(_url),
              Text('FittedBox缩放和调整位置', style: TextStyle(fontSize: 48, color: Colors.white),),
            ],
          ),)),

          Container(
              width: 200,
              height: 200,
              color: Colors.cyanAccent,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.5,
                child: Card(child: Text('FractionallySizedBox设置Child的相对于自己比率'), color: Colors.amber,),
              )
          ),
          IntrinsicHeight(
            child: Row(children: [
              Container(width: 100, height: 100, color: Colors.cyanAccent, child: Text('IntrinsicHeight作用会将子组建高度拉直填充父组件'),),
              VerticalDivider(),
              Container(width: 150, color: Colors.cyanAccent)
            ],),
          ),
          Row(children: [
            Container(width: 100, height: 100, color: Colors.deepOrange,),
            Container(width: 150, color: Colors.deepOrangeAccent,)
          ],),

          IntrinsicWidth(),
          /// 设置未知的组件长宽的组件的限制
          LimitedBox(maxHeight: 200, child: Image.network(_url),),

          Row(
            children: [
              Offstage(offstage: true, child: Text('AAA')),
              Text('BBB')
            ],
          ),
          Container(
            width: 200,
            height: 200,
            color: Colors.greenAccent,
            child: OverflowBox(minHeight: 100, maxHeight: 200, child: Column(
              children: [
                SizedBox(height: 100,),
                Container(height: 150, color: Colors.green,)
              ],
            ),),
          ),
          Container(width: 200, height: 200, child: Transform.rotate(angle: 90, child: FlutterLogo(size: 20,), )),
          Container(
            width: 200,
            height: 200,
            color: Colors.indigo,
            child: Stack(children: [
              Card(child: Text('AAA', style: TextStyle(fontSize: 24),)),
              Card(child: Text('BBB', style: TextStyle(fontSize: 24),)),
            ],),
          ),
          Container(
            width: 200,
            height: 200,
            color: Colors.indigo,
            child: IndexedStack(children: [
              Card(child: Text('AAA', style: TextStyle(fontSize: 24),)),
              Card(child: Text('BBB', style: TextStyle(fontSize: 24),))
            ],),
          ),
          // Flow(delegate: MyFlowDelegate()),
          Wrap(children: [
            Container(width: 200, color: Colors.black, height: 60,),
            Container(width: 200, color: Colors.black12, height: 60,),
            Container(width: 200, color: Colors.black26, height: 60,),
            Container(width: 200, color: Colors.black38, height: 60,),
            Container(width: 200, color: Colors.black45, height: 60,),
          ],),
          Divider(),
          ListBody(children: [
            Container(width: 200, color: Colors.black12, height: 60, child: Text('ListBody'),),
          ],),
          Table(children: [
            TableRow(children: [
              Text('姓名/Name'), Text('年龄/Age'), Text('身高/Height')
            ]),
            TableRow(children: [
              Text('TianLin'), Text('22'), Text('177')
            ]),
            TableRow(children: [
              Text('TianLin'), Text('22'), Text('171')
            ], decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))))
          ], border: TableBorder.symmetric(inside: BorderSide(), outside: BorderSide()),),
          Container(
            width: 200,
            height: 200,
            color: Colors.lightBlue,
            child: CustomMultiChildLayout(delegate: MyMultiChildLayoutDelegate(), children: [
              LayoutId(id: 'AAA', child: Card(child: Text('AAA', style: TextStyle(fontSize: 24),))),
              LayoutId(id: 'BBB', child: Card(child: Text('BBB', style: TextStyle(fontSize: 24),)))
            ],),
          )
        ],
      ),
    );
  }
}

class MyMultiChildLayoutDelegate extends MultiChildLayoutDelegate {

  @override
  void performLayout(Size size) {
    print('performLayout = ' + size.toString());
    layoutChild('BBB', BoxConstraints());
    layoutChild('AAA', BoxConstraints());
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }

}
class MyFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }

}
class MySingleChildLayoutDelegate extends SingleChildLayoutDelegate{

  @override
  Size getSize(BoxConstraints constraints) {
    print('constraints = ' + constraints.toString());
    return constraints.constrain(Size(200, 200));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(size.width / 2, 0);
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    return oldDelegate == this;
  }

}
