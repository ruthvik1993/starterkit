import 'package:flutter/material.dart';
import 'profile_card_dragable.dart';
import 'package:starterkit/home_page.dart';


class TinderSwipeTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new MyHomePage(),
      backgroundColor: Colors.blue,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> cardList;
  List<ProfileCardDraggable> cards = new List();
  int cardsCounter = 0;
  bool dragOverTarget = false;

  Widget _buildAppBar() {
    return new AppBar(
      title: new Text("Tinder Swipe"),
      actions: <Widget>[
        IconButton(
          icon: Image.asset('assets/ic_delete.png'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0.0,
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new CustomButton.large(
              icon: Icons.clear,
              iconColor: Colors.red,
              onPressed: () {},
            ),
            new CustomButton.small(
              icon: Icons.refresh,
              iconColor: Colors.orange,
              onPressed: () {
                if (cardList != null && cardList.length == 0) {
                  cardList = _getMatchCard(addCards());
                  setState(() {});
                }
              },
            ),
            new CustomButton.large(
              icon: Icons.favorite,
              iconColor: Colors.green,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _removeCard(index) {
    setState(() {
      cardList.removeAt(cardList.length - 1);
    });
  }

  List<CardModel> addCards() {
    List<CardModel> cardsList = new List();
    CardModel card1 = new CardModel("photo1", "assets/photo_1.jpg");
    CardModel card2 = new CardModel("photo2", "assets/photo_2.jpg");
    CardModel card3 = new CardModel("photo3", "assets/photo_3.jpg");
    CardModel card4 = new CardModel("photo4", "assets/photo_4.jpg");
    CardModel card5 = new CardModel("photo5", "assets/photo_5.jpg");
    CardModel card6 = new CardModel("photo6", "assets/photo_6.jpg");
    CardModel card7 = new CardModel("photo7", "assets/photo_7.jpg");

    cardsList.add(card1);
    cardsList.add(card2);
    cardsList.add(card3);
    cardsList.add(card4);
    cardsList.add(card5);
    cardsList.add(card6);
    cardsList.add(card7);

    return cardsList;
  }

  Widget dragTarget() {
    return new Flexible(
      flex: 1,
      child: new DragTarget(
          builder: (_, __, ___) {
            return new Container(
              color: Colors.black,
            );
          },
          onWillAccept: (_) {
            setState(() => dragOverTarget = true);
            return true;
          },
          onAccept: (_) {
            _removeCard(1);
            // changeCardsOrder();
            setState(() => dragOverTarget = false);
          },
          onLeave: (_) => setState(() => dragOverTarget = false)),
    );
  }

  @override
  void initState() {
    super.initState();
/*
    for (cardsCounter = 0; cardsCounter < 3; cardsCounter++) {
      cards.add(new ProfileCardDraggable(cardsCounter));
    }*/
    cardList = _getMatchCard(addCards());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: new Stack(children: cardList),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  List<Widget> _getMatchCard(List<CardModel> cardsList) {
    List<Widget> cardList = new List();
    for (int x = 0; x < cardsList.length; x++) {
      cardList.add(Positioned(
        child: Draggable(
          onDragEnd: (drag) {
            print("drag.offset" + drag.offset.toString());
            if (drag.offset.dx > 240.0 && drag.offset.dy > 100 ||
                (drag.offset.dx < -250.0 && drag.offset.dy > 100.0)) {
              _removeCard(x);
            }
            //
          },
          childWhenDragging: Container(),
          feedback: new Container(
            child: getCardWidget(cardsList[x]),
          ),
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: getCardWidget(cardsList[x])),
        ),
      ));
    }
    return cardList;
  }

  void changeCardsOrder() {
    setState(() {
      // Swap cards
      var temp = cards[0];
      cards[0] = cards[1];
      cards[1] = cards[2];
      cards[2] = temp;

      cards[2] = new ProfileCardDraggable(cardsCounter);
      cardsCounter++;
    });
  }

  Widget getCardWidget(CardModel cardModel) {
    return Container(
      height: 600,
      width: 400,
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: new Column(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                cardModel.imageName,
                fit: BoxFit.fill,
              ),
              flex: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                  child: new Text(
                    cardModel.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  CustomButton.large({
    this.icon,
    this.iconColor,
    this.onPressed,
  }) : size = 60.0;

  CustomButton.small({
    this.icon,
    this.iconColor,
    this.onPressed,
  }) : size = 50.0;

  CustomButton({
    this.icon,
    this.iconColor,
    this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: const Color(0x11000000),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: new RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: new Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class MatchCard {
  int redColor = 0;
  int greenColor = 0;
  int blueColor = 0;
  double margin = 0;

  MatchCard(int red, int green, int blue, double marginTop) {
    redColor = red;
    greenColor = green;
    blueColor = blue;
    margin = marginTop;
  }
}

class CardModel {
  String title;
  String imageName;

  CardModel(String title, String imageName) {
    this.title = title;
    this.imageName = imageName;
  }
}
