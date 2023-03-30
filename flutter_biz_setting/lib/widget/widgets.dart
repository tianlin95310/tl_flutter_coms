part of biz_setting;

class WidgetsPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return WidgetsState();
  }
}

class WidgetWrapper extends StatelessWidget {
  final Widget child;
  final String msg;
  //
  // Widget get child => _child;
  //
  // set child(Widget value) {
  //   _child = value;
  // }
  WidgetWrapper({this.child, this.msg});

  @override
  Widget build(BuildContext context) {
    if (this.child == null) {
      return Container();
    }
    String msg = this.msg ?? this.child.runtimeType.toString();
    Widget child = this.child ?? Container();
    return Tooltip(
        message: msg,
        child: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: child,
        ));
  }
}

class WidgetsState extends BasePageTitleState {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget widgetWrapper({Widget child, String msg = ''}) {
    return Container();
  }

  @override
  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text('布局组件'),
            subtitle: Text('主要是根布局相关的组件'),
            leading: Icon(Icons.looks_one),
            trailing: Icon(Icons.looks_one_outlined),
            // visualDensity: VisualDensity(vertical: 1, horizontal: 2),
            dense: false,
            enableFeedback: false,
            onTap: () {
              Navigator.pushNamed(context, 'LayoutComp');
            },
          ),
          Divider(height: 1,),
          ListTile(
            title: Text('Material组件'),
            subtitle: Text('Material Design 风格的组件'),
            leading: Icon(Icons.looks_two),
            trailing: Icon(Icons.looks_two_outlined),
            // visualDensity: VisualDensity(vertical: 1, horizontal: 2),
            dense: false,
            enableFeedback: false,
            onTap: () {
              Navigator.pushNamed(context, 'MaterialComp');
            },
          ),
          Divider(height: 1,),
          ListTile(
            title: Text('Cupertino组件'),
            subtitle: Text('Cupertino风格的组件'),
            leading: Icon(Icons.looks_3),
            trailing: Icon(Icons.looks_3_outlined),
            // visualDensity: VisualDensity(vertical: 1, horizontal: 2),
            dense: false,
            enableFeedback: false,
            onTap: () {
              Navigator.pushNamed(context, 'CupertinoComp');
            },
          ),
          Divider(height: 1,),
          ListTile(
            title: Text('Sliver嵌套滚动组件'),
            subtitle: Text('Sliver嵌套滚动风格的组件'),
            leading: Icon(Icons.looks_4),
            trailing: Icon(Icons.looks_4_outlined),
            // visualDensity: VisualDensity(vertical: 1, horizontal: 2),
            dense: false,
            enableFeedback: false,
            onTap: () {
              Navigator.pushNamed(context, 'SliverComp');
            },
          ),
          Divider(height: 1,),
          ListTile(
            title: Text('动画组件'),
            subtitle: Text('动画风格的组件'),
            leading: Icon(Icons.looks_5),
            trailing: Icon(Icons.looks_5_outlined),
            // visualDensity: VisualDensity(vertical: 1, horizontal: 2),
            dense: false,
            enableFeedback: false,
            onTap: () {
              Navigator.pushNamed(context, 'AnimComp');
            },
          ),
          Divider(height: 1,),
          ListTile(
            title: Text('用户交互组件'),
            subtitle: Text('用于用户交互的组件'),
            leading: Icon(Icons.looks_6),
            trailing: Icon(Icons.looks_6_outlined),
            // visualDensity: VisualDensity(vertical: 1, horizontal: 2),
            dense: false,
            enableFeedback: false,
            onTap: () {
              Navigator.pushNamed(context, 'GestureComp');
            },
          ),
          Divider(height: 1,),
          ListTile(
            title: Text('Canvas Paint自定义组件'),
            subtitle: Text('基于Canvas自定义的组件'),
            leading: Icon(Icons.eighteen_up_rating),
            trailing: Icon(Icons.eighteen_up_rating_outlined),
            // visualDensity: VisualDensity(vertical: 1, horizontal: 2),
            dense: false,
            enableFeedback: false,
            onTap: () {
              Navigator.pushNamed(context, 'CustomWidgets');
            },
          ),
        ],
      ),
    );
  }

  @override
  String getTitle(BuildContext context) {
    return 'flutter 组件';
  }
}
