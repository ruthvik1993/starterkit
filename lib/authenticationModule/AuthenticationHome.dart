import 'package:starterkit/authenticationModule/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:starterkit/authenticationModule/SignIn.dart';

class AuthenticationHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final signup_button = new SizedBox(
        width: double.infinity,
        child: new RaisedButton(
          onPressed: _sigup,
          elevation: 0,
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(15.0),
          child: new Text(
            "SIGN UP",
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30),
              side: BorderSide(color: Colors.white)),
        ));

    final signin_button = new SizedBox(
        width: double.infinity,
        child: new RaisedButton(
          onPressed: _sigin,
          elevation: 0,
          textColor: Colors.white,
          color: Colors.white,
          padding: const EdgeInsets.all(15.0),
          child: new Text(
            "SIGN IN",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30),
              side: BorderSide(color: Colors.white)),
        ));

    final logo = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/logo.png'),
        SizedBox(height: 20.0),
        new Text(
          'Company Name',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ],
    );

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/ic_delete.png'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: new Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: new Column(
            children: <Widget>[
              new Flexible(
                child: logo,
                flex: 1,
              ),
              new Flexible(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    signup_button,
                    new SizedBox(
                      height: 20,
                    ),
                    signin_button,
                  ],
                ),
                flex: 1,
              )
            ],
          )),
    );
  }

  void _sigup() {
    // Navigate to Signup Screen
  }

  void _sigin() {
    // Navigate to SignIn Screen
//    Navigator.of(context).pushReplacementNamed(new SignIn());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }
}
