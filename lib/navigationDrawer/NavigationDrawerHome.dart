import 'package:flutter/material.dart';
import 'Fragments/Fragment1.dart';
import 'Fragments/Fragment2.dart';
import 'Fragments/Fragment3.dart';
import 'Fragments/Fragment4.dart';
import 'Fragments/Fragment5.dart';
import 'package:starterkit/home_page.dart';
import 'Utils/Utils.dart';

class NavigationDrawerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(title: 'Flutter Navigation Drawer'),
      backgroundColor: Colors.blue,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedFragmentIndex = 0;

  Widget _getFragmentWidget(int pos) {
    print("selected index is" + pos.toString());
    switch (pos) {
      case 0:
        return new Fragment1();
        break;
      case 1:
        return new Fragment2();
        break;
      case 2:
        return new Fragment3();
        break;
      case 3:
        return new Fragment4();
        break;
      case 4:
        return new Fragment5();
        break;
      default:
        return new Text("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Navigation Drawer"),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/ic_delete.png'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Flutter StarterKit"),
              accountEmail: new Text("xyz@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Text("A"),
              ),
              otherAccountsPictures: <Widget>[
                new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Text("B"),
                )
              ],
            ),
            new ListTile(
              title: new Text("First Fragment"),
              trailing: new Icon(Icons.camera),
              selected: 0 == _selectedFragmentIndex,
              onTap: () {
                _onSelectItem(0);
              },
            ),
            new ListTile(
              title: new Text("Second Fragment"),
              trailing: new Icon(Icons.filter),
              selected: 1 == _selectedFragmentIndex,
              onTap: () {
                _onSelectItem(1);
              },
            ),
            new ListTile(
              title: new Text("Third Fragment"),
              trailing: new Icon(Icons.phone_locked),
              selected: 2 == _selectedFragmentIndex,
              onTap: () {
                _onSelectItem(2);
              },
            ),
            new Divider(
              height: 35,
              color: Colors.black45,
            ),
            new ListTile(
              title: new Text("Fourth Fragment"),
              trailing: new Icon(Icons.account_balance),
              selected: 3 == _selectedFragmentIndex,
              onTap: () {
                _onSelectItem(3);
              },
            ),
            new ListTile(
              title: new Text("Fifth Fragment"),
              trailing: new Icon(Icons.camera_roll),
              selected: 4 == _selectedFragmentIndex,
              onTap: () {
                _onSelectItem(4);
              },
            ),
          ],
        ),
      ),
      body: new Container(child: _getFragmentWidget(_selectedFragmentIndex)),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onSelectItem(int index) {
    setState(() {
      _selectedFragmentIndex = index;
    });
    Navigator.of(context).pop();
  }
}
