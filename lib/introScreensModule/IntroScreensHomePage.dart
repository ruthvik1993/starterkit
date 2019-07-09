import 'package:flutter/material.dart';
import 'package:starterkit/introScreensModule/Utils/Utils.dart';

class IntroScreenHomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(title: 'Flutter IntroScreens'),
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/ic_delete.png'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Widget> dots = new List();
  List<Widget> tabs = new List();

  Color activeDotColor = Color(0xffffffff);
  Color inActiveDotColor = Color(0x80000000);
  Color btnBackgroundColor = Colors.transparent;
  Color btnHighlightColor = Colors.white.withOpacity(0.3);
  Color inactiveDot;


  double borderRadius = 30.0;
  int slidesCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: slidesCount,
        child: Stack(
          children: <Widget>[
            TabBarView(
              children: tabs,
              controller: tabController,
            ),
            renderBottomViewLine(),
            renderBottomView(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: slidesCount, vsync: this);
    tabController.addListener(() {
      this.setState(() {});
    });
    initializeTabs();
  }

  List<Widget> initializeTabs() {
    tabs.add(getContainer(
        "Daily Workout",
        "ic_workout.png",
        Utils.createMaterialColor(Color(0xFFF4B242)),
        "Set your daily workout routine by the help of trainer"));
    tabs.add(getContainer(
        "Meditation Techniques",
        "ic_meditation.png",
        Utils.createMaterialColor(Color(0xFF19BC7C)),
        "Learn different meditation techniques and practice them"));
    tabs.add(getContainer(
        "Diet Plan",
        "ic_diet.png",
        Utils.createMaterialColor(Color(0xFF1F3E8A)),
        "Make your diet chart by the help of health experts"));
  }

  Widget getContainer(String header, String imageType, MaterialColor colorIndex,
      String description) {
    return new Container(
      width: double.infinity,
      height: double.infinity,
      color: colorIndex,
      padding: EdgeInsets.fromLTRB(30, 40, 30, 40),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          headerText(header),
          new SizedBox(
            height: 30,
          ),
          image(imageType),
          new SizedBox(
            height: 30,
          ),
          descriptionWidget(description),
        ],
      ),
    );
  }

  Widget renderBottomView() {
    return Positioned(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Skip button
          Container(
            alignment: Alignment.center,
            child: buildSkipButton(),
          ),

          // Dot indicator
          Flexible(
            child: Row(
              children: renderListDots(),
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),

          // Next, Done button
          Container(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: tabController.index + 1 == slidesCount
                ? buildDoneButton()
                : buildNextButton(),
            width: MediaQuery.of(context).size.width / 4,
          ),
        ],
      ),
      bottom: 10.0,
      left: 10.0,
      right: 10.0,
    );
  }

  Widget renderBottomViewLine() {
    return Positioned(
      child: new Divider(
        height: 45,
        color: Colors.white,
      ),
      bottom: 40.0,
      left: 0.0,
      right: 0.0,
    );
  }

  final renderSkipBtn = Text(
    "Skip",
    style: new TextStyle(fontSize: 16, color: Colors.white),
  );

  Widget buildNextButton() {
    return FlatButton(
      onPressed: () {
        tabController.animateTo(tabController.index + 1);
      },
      child: renderNextBtn,
      color: btnBackgroundColor,
      highlightColor: btnHighlightColor,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(borderRadius)),
    );
  }

  final renderNextBtn = Text(
    "Next",
    style: new TextStyle(fontSize: 16, color: Colors.white),
  );

  final renderDoneButton = Text(
    "Done",
    style: new TextStyle(fontSize: 16, color: Colors.white),
  );

  Widget headerText(String headerText) {
    return new Text(
      headerText,
      style: new TextStyle(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget image(String imageType) {
    return new Image.asset(
      'assets/' + imageType,
      height: 100,
      width: 100,
    );
  }

  Widget descriptionWidget(String description) {
    return new Text(
      description,
      style: new TextStyle(fontSize: 20, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  List<Widget> renderListDots() {
    dots.clear();
    for (int i = 0; i < slidesCount; i++) {
      Color currentColor;
      if (tabController.index == i) {
        currentColor = activeDotColor;
      } else {
        currentColor = inActiveDotColor;
      }
      dots.add(renderDot(8.0, currentColor));
    }
    return dots;
  }

  Widget renderDot(double radius, Color color) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius / 2)),
      width: radius,
      height: radius,
      margin: EdgeInsets.all(radius / 2),
    );
  }

  Widget buildSkipButton() {
    if (tabController.index + 1 == slidesCount) {
      return Container(width: MediaQuery.of(context).size.width / 4);
    } else {
      return FlatButton(
        onPressed: onSkipPress,
        child: renderSkipBtn,
        color: Colors.transparent,
        highlightColor: Colors.white.withOpacity(0.3),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
      );
    }
  }

  void onSkipPress() {
    tabController.animateTo(slidesCount - 1);
  }

  Widget buildDoneButton() {
    return FlatButton(
      onPressed: onDonePress,
      child: renderDoneButton,
      color: btnBackgroundColor,
      highlightColor: btnHighlightColor,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(borderRadius)),
    );
  }

  void onDonePress() {}
}