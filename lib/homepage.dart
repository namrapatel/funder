import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:funder/widgets/colorCard.dart';
import 'notificationspage.dart';
import 'profilepage.dart';

Color firstColor = Colors.greenAccent[400];
Color secondColor = Colors.greenAccent[700];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[HomePageTopPart(), homePageBottomPart],
    ));
  }
}

final bodyTextStyle = TextStyle(color: Colors.black, fontFamily: "Varela");
final titleTextStyle = TextStyle(
  color: Colors.grey[100],
  fontFamily: "Varela",
  fontSize: 24.0,
);

class HomePageTopPart extends StatefulWidget {
  HomePageTopPart({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageTopPartState createState() => new _HomePageTopPartState();
}

class _HomePageTopPartState extends State<HomePageTopPart> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        height: 305.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [firstColor, secondColor],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 305.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Row(children: <Widget>[
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            "Dime",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 280,
                          ),
                          IconButton(
                            iconSize: 25.0,
                            color: Colors.white,
                            icon: Icon(Icons.settings),
                            onPressed: () {},
                          ),
                        ]),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 17.5),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Text(
                            "What would you like to do?",
                            style: titleTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Row(
                            children: <Widget>[
                              buildColorCard(context, "Create a Group",
                                  Icon(Icons.group_add), Colors.grey[50]),
                              buildColorCard(context, "Send a Dime",
                                  Icon(Icons.send), Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ]);
  }
}

var viewAllStyle = TextStyle(color: Colors.greenAccent[700], fontSize: 14.0);
var regularBlackStyle = TextStyle(
  color: Colors.black,
  fontSize: 18.0,
);

var homePageBottomPart = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Your Groups", style: regularBlackStyle),
          Spacer(),
          Text(
            "VIEW ALL (9)",
            style: viewAllStyle,
          )
        ],
      ),
    ),
    Container(
      height: 450,
      child: ListView(
        children: groupCards,
        scrollDirection: Axis.vertical,
      ),
    )
  ],
);

List<GroupCard> groupCards = [
  GroupCard("assets/roommates.jpeg", "Roommates", 4, 59.34, true, Colors.red),
  GroupCard("assets/childhoodhomies.jpeg", "Childhood Homies", 7, 178.33, false,
      Colors.greenAccent[400]),
  GroupCard("assets/sorority.jpeg", "Alpha Beta Phi", 44, 11.19, true,
      Colors.greenAccent[400]),
  GroupCard("assets/lakersnation.jpeg", "Lakers Nation", 7, 55.90, false,
      Colors.greenAccent[400]),
  GroupCard("assets/trip.png", "Backpacking Gang", 13, 24.09, true,
      Colors.greenAccent[400]),
  GroupCard("assets/family.png", "Family", 6, 329.11, true, Colors.red),
];

class GroupCard extends StatelessWidget {
  final String imagePath, groupName;
  final bool settleType;
  final double settleAmount;
  final int membersNumber;
  final Color indicatorColor;
  final greenSubStyle =
      TextStyle(color: Colors.greenAccent[700], fontSize: 15.0);
  final redSubStyle = TextStyle(color: Colors.red, fontSize: 15.0);

  GroupCard(this.imagePath, this.groupName, this.membersNumber,
      this.settleAmount, this.settleType, this.indicatorColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
            height: 100.0,
            child: ListTile(
                leading: CircleAvatar(
                    radius: 30.0, backgroundImage: AssetImage(this.imagePath)),
                title: Text(
                  groupName,
                  style: regularBlackStyle,
                ),
                subtitle: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 1.0,
                    ),
                    Text("${membersNumber.toString()} members "),
                    Spacer(),
                    Text(
                      "${settleType == false ? "+" : "-"} \$${settleAmount.toString()}",
                      style: settleType == false ? greenSubStyle : redSubStyle,
                    ),
                  ],
                )),
          ),
        )
      ]),
    );
  }
}

class BottomBar extends StatefulWidget {
  BottomBar();
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            color: Colors.white,
            child: HomePage(),
          ),
          Container(color: Colors.white, child: NotificationsPage()),
          Container(
            color: Colors.white,
            child: ProfilePage(),
          ),
        ],
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
// Creating the actual bottom app bar using the CupertinoTabBar widget.
      bottomNavigationBar: CupertinoTabBar(
        activeColor: Colors.greenAccent[400],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: (_page == 0) ? Colors.greenAccent[400] : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications,
                  color: (_page == 1) ? Colors.greenAccent[400] : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: (_page == 2) ? Colors.amber[800] : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
