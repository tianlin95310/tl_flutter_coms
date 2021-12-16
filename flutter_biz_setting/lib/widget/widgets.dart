part of biz_setting;

class WidgetsPage extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return WidgetsState();
  }
}

class WidgetsState extends BasePageTitleState {
  @override
  Widget getBody(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              // widthFactor: 1,
              // heightFactor: 1,
              alignment: Alignment.bottomCenter,
              child: Text('床前明月光'),
            ),
            AppBar(
              leading: Icon(Icons.ac_unit),
              title: Text('标题'),
              actions: [Icon(Icons.access_alarm)],
            ),
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                color: Colors.cyanAccent,
                height: 100,
              ),
            ),
            BottomNavigationBar(items: [
              BottomNavigationBarItem(label: 'tab1', icon: Icon(Icons.accessibility)),
              BottomNavigationBarItem(label: 'tab2', icon: Icon(Icons.cabin))
            ]),
            Card(
              child: ButtonBar(children: [
                TextButton(child: Text('按钮1'),),
                OutlinedButton(onPressed: (){}, child: Text('按钮2')),
                FloatingActionButton(onPressed: (){}),
                IconButton(onPressed: (){}, icon: Icon(Icons.add)),
                ElevatedButton(onPressed: (){}, child: Text('ElevatedButton'))
                // RaisedButton(onPressed: onPressed)
                // FlatButton(onPressed: onPressed, child: child)
              ],),
            ),
            Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value){}),
                      Radio(value: 1, groupValue: 1, onChanged: (value){}),
                      Radio(value: 2, groupValue: 1, onChanged: (value){}),
                      Switch(value: true, onChanged: (value){})
                    ],
                  )
                ],
              ),
            ),
            Chip(label: Text('用户名')),
            ClipOval(child: Text('疑是地上霜'), clipBehavior: Clip.hardEdge),
            CupertinoActivityIndicator(animating: true,),
            CupertinoButton(child: Text('Ios风格按钮'), onPressed: (){},),
            CupertinoNavigationBar(
              leading: Icon(Icons.arrow_back_ios),
              trailing: Text('FF'),
              previousPageTitle: '标题',
            ),
            Card(
              child: Column(
                children: [
                  CupertinoSlider(value: 10, onChanged: (value){}, min: 0, max: 100,),
                  CupertinoSwitch(value: true, onChanged: (value){}),
                  Row(children: [
                    Slider(value: 20, onChanged: (value){}, min: 10, max: 90,)
                  ],)
                ],
              ),
            ),
            CupertinoTabBar(items: [
              BottomNavigationBarItem(label: 'tab1', icon: Icon(Icons.accessibility)),
              BottomNavigationBarItem(label: 'tab2', icon: Icon(Icons.cabin))
            ]),
            // Dismissible(key: Key('sss'), child: Container(width: 80, height: 80, color: Colors.red,), onDismissed: (DismissDirection direction){},),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(height: 1,thickness: 1,),
            ),
            LinearProgressIndicator(value: 20, ),
            // RawKeyboardListener(focusNode: focusNode, child: child),
            Scrollbar(child: Container(width: 1000,height: 30, child: Text('1234567890qwertyuiopasdfghjklzxcvbnm1234567890qwertyuiopasdfghjklzxcvbnm1234567890qwertyuiopasdfghjklzxcvbnm'),))
          ],
        ),
      ),
    );
  }
}
