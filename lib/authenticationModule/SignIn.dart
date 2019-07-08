import 'package:starterkit/authenticationModule/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class SignIn extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        dialogBackgroundColor: Colors.white,
        accentColor: Utils.createMaterialColor(Color(0xFFDFDCD8)),
        primaryColor: Utils.createMaterialColor(Color(0xFF0ACB7B)),
      ),
      home: LoginInScreen(),
    );
  }
}

class LoginInScreen extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<LoginInScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBioMetric = false;
  String _authorizedOrNot = "Not Authorized";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();

  @override
  void initState() {
    super.initState();
     _checkBiometric();
    if (_canCheckBioMetric) {
       _getListOfBiomentricTypes();
    }
  }

  Future<void> _checkBiometric() async {
    bool canCheckBioMetric = false;
    try {
      canCheckBioMetric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _canCheckBioMetric = canCheckBioMetric;
    });
  }

  Future<void> _getListOfBiomentricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listOfBiometrics;
    });
  }

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
          localizedReason: "please authenticate to proceed further",
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Authorized";
      } else {
        _authorizedOrNot = "Not Authorized";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = new Container(
      alignment: Alignment(0.0, 0.0),
      child: Image.asset('assets/logo.png'),
    );

    /*final FocusNode _usernameFocus = FocusNode();
    final FocusNode _passwordFocus = FocusNode();*/

    final username = new TextFormField(
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: 'USERNAME', labelStyle: TextStyle(fontSize: 14)),
      style: TextStyle(color: Utils.createMaterialColor(Color(0xFF7C7B90))),
      keyboardType: TextInputType.emailAddress,
//      focusNode: _usernameFocus,
      autofocus: true,
      validator: (String arg) {
        if (arg == null || arg.trim() == null || arg.length == 0) {}
      },
      /*onFieldSubmitted: (term) {
        _usernameFocus.unfocus();
        FocusScope.of(context).requestFocus(_passwordFocus);
      },*/
    );

    final password = new TextFormField(
      decoration: const InputDecoration(
          labelText: 'PASSWORD', labelStyle: TextStyle(fontSize: 14)),
      style: TextStyle(color: Utils.createMaterialColor(Color(0xFF7C7B90))),
      obscureText: true,
      //focusNode: _passwordFocus,
      autofocus: false,
      validator: (String arg) {
        if (arg == null || arg.trim() == null || arg.length == 0) {}
      },
    );

    final signin_button = new Container(
      child: Row(
        children: <Widget>[
          new Expanded(
            child: RaisedButton(
              onPressed: _siginRequest,
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
                side: BorderSide(color: Colors.white),
              ),
            ),
          ),
          getBiometricWidget(),
        ],
      ),
    );

    final forgot_password = new Container(
      alignment: Alignment(1.0, 0.0),
      child: new Text(
        "Forgot Password?",
        textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: 14, color: Utils.createMaterialColor(Color(0xFF7C7B90))),
      ),
    );

    final divider = new Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: Divider(
              color: Utils.createMaterialColor(Color(0xFF7C7B90)),
              height: 36,
            )),
      ),
      Text(
        "OR CONNECT WITH",
        style: TextStyle(
            fontSize: 10, color: Utils.createMaterialColor(Color(0xFF7C7B90))),
      ),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 0.0),
            child: Divider(
              color: Utils.createMaterialColor(Color(0xFF7C7B90)),
              height: 36,
            )),
      ),
    ]);

    final facebook_button = new SizedBox(
        child: new RaisedButton.icon(
      icon: Image.asset(
        'assets/ic_facebook.png',
        width: 25,
        height: 25,
      ),
      onPressed: _siginRequest,
      elevation: 0,
      textColor: Colors.white,
      color: Color(0xff3B5998),
      label: new Text(
        "FACEBOOK",
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30),
      ),
    ));

    final googleplus_button = new SizedBox(
        child: new RaisedButton.icon(
      icon: Image.asset(
        'assets/ic_googleplus.png',
        width: 25,
        height: 25,
      ),
      onPressed: _siginRequest,
      elevation: 0,
      textColor: Colors.white,
      color: Color(0xffDD4B39),
      label: new Text(
        "GOOGLE+",
        style: TextStyle(fontSize: 15, color: Colors.white),
      ),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30),
      ),
    ));

    final social_logins = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[facebook_button, googleplus_button],
      ),
    );

    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
          child: new Column(
            children: <Widget>[
              new Flexible(
                child: logo,
                flex: 1,
              ),
              new Flexible(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    username,
                    new SizedBox(
                      height: 15,
                    ),
                    password,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new SizedBox(
                        height: 15,
                      ),
                    ),
                    forgot_password,
                    new SizedBox(
                      height: 30,
                    ),
                    signin_button,
                    new SizedBox(
                      height: 15,
                    ),
                    divider,
                    new SizedBox(
                      height: 15,
                    ),
                    social_logins
                  ],
                ),
                flex: 2,
              )
            ],
          )),
    );
  }

  static void _siginRequest() {}

  Widget getBiometricWidget() {
    if (_canCheckBioMetric) {
      return new GestureDetector(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Image.asset('assets/ic_finger_print.png'),
        ),
        onTap: () {
          _authorizeNow();
        },
      );
    } else {
      return new Text("");
    }
  }
}
