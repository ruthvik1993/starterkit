import 'package:flutter/material.dart';
import 'Utils/Utils.dart';
import 'package:starterkit/home_page.dart';


class TabViewHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(title: 'Flutter Tabs Demo'),
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(
              icon: Icon(Icons.directions_transit),
            ),
            Tab(
              icon: Icon(Icons.directions_bike),
            )
          ]),
          title: Text("Flutter Tabs Demo"),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/ic_delete.png'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: TabBarView(children: [
          Icon(Icons.directions_car),
          Icon(Icons.directions_transit),
          Icon(Icons.directions_bike),
        ]),
      ),
    ));
  }
}
