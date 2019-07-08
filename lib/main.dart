import 'package:flutter/material.dart';
import 'dart:async';
import 'package:starterkit/home_page.dart';

void main() => runApp(new MaterialApp(
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/LandingScreen': (BuildContext context) => new HomePage()
      },
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/LandingScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage('assets/starterkit_logo.jpg');
    return new Scaffold(
        body: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image(
            image: assetImage,
            width: 150.0,
            height: 150.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 10, 0),
          ),
        ],
      ),
    ));
  }
}
