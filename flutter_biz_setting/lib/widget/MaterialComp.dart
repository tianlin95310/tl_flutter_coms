import 'package:flutter/material.dart';
import 'package:tl_flutter_common/base/base-widget.dart';

class MaterialComp extends BaseStatefulWidget {
  @override
  State<StatefulWidget> getState() {
    return MaterialCompState();
  }
}

class MaterialCompState extends BasePageTitleState {

  final _url = 'https://img2.baidu.com/it/u=3202947311,1179654885&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500';

  int _currentIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBar(
            leading: Icon(Icons.ac_unit),
            title: Text('标题'),
            actions: [Icon(Icons.access_alarm), Icon(Icons.search)],
          ),
          ButtonBar(children: [
            Text('AAA'),
            Text('CCC')
          ],),
          Row(children: [
            TextButton(
              child: Text('按钮1'),
              onPressed: () {},
            ),
            OutlinedButton(onPressed: () {}, child: Text('按钮2')),
            FloatingActionButton(onPressed: () {}, child: Icon(Icons.add),),
            ElevatedButton(onPressed: () {}, child: Text('ElevatedButton')),
          ],),
          Row(children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            BackButton(),
            CloseButton(),
              DropdownButton<String>(
                items: [
                  DropdownMenuItem(
                    child: Text('AAA'),
                    value: 'AAA',
                  ),
                  DropdownMenuItem(
                    child: Text('BBB'),
                    value: 'BBB',
                  ),
                  DropdownMenuItem(
                    child: Text('CCC'),
                    value: 'CCC',
                  )
                ],
                hint: Text('请选择'),
                value: 'AAA',
                onChanged: (index) {},
                onTap: () {},
                icon: Icon(Icons.pie_chart_outline_sharp),
              )
            ],
          ),

          PopupMenuButton<String>(itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              CheckedPopupMenuItem(value: 'AAA', child: Text('AAA'),),
              PopupMenuDivider(),
              CheckedPopupMenuItem(value: 'BBB', child: Text('BBB'),),
              PopupMenuItem<String>(child: Text('CCC')),
            ];
          }, initialValue: 'AAA',),

          Card(child: Column(
            children: [
              Chip(label: Text('Chip Text')),
              ClipOval(child: Text('疑是地上霜'), clipBehavior: Clip.hardEdge),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(value: 20, color: Colors.lightBlueAccent,),
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: 170,
                height: 200,
                // 滚动条
                child: Scrollbar(
                  scrollbarOrientation: ScrollbarOrientation.right,
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1000,
                          child: Text(
                              '1234567890qwertyuiopasdfghjklzxcvbnm1234567890qwertyuiopasdfghjklzxcvbnm1234567890qwertyuiopasdfghjklzxcvbnm'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RawKeyboardListener(focusNode: FocusNode(), child: TextField()),

            ],
          ),),

          // Form(key: _formKey, child: Column(children: [
          //   TextFormField()
          // ],)),

          BottomNavigationBar(
            currentIndex: _currentIndex,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  label: 'tab1', icon: Icon(Icons.accessibility)),
              BottomNavigationBarItem(
                  label: 'tab2',
                  icon: Icon(Icons.baby_changing_station)),
              BottomNavigationBarItem(
                  label: 'tab3', icon: Icon(Icons.cabin)),
              BottomNavigationBarItem(
                  label: 'tab4', icon: Icon(Icons.dangerous)),
              BottomNavigationBarItem(
                  label: 'tab5', icon: Icon(Icons.eight_k))
            ],
            onTap: (int index) {
              setState(() {
                this._currentIndex = index;
              });
            },
          )
        ],
      ),
    );
  }
}
