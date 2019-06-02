import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:funder/widgets/colorCard.dart';
import 'notificationspage.dart';
import 'groupspage.dart';
import 'profilepage.dart';

Color firstColor = Colors.greenAccent[400];
Color secondColor = Colors.greenAccent[700];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: BottomBar(),
        body: Column(
      children: <Widget>[
        HomePageTopPart(),
      ],
    ));
  }
}

final bodyTextStyle = TextStyle(color: Colors.black, fontFamily: "Varela");
final titleTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Varela",
    fontSize: 20.0,
    fontWeight: FontWeight.bold);

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
          // color: Colors.white
          gradient: LinearGradient(
            colors: [firstColor, secondColor],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              // color: Colors.white,
              height: 305.0,
              child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 50,
                  ),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          IconButton(
                            iconSize: 25.0,
                            color: Colors.white,
                            icon: Icon(Icons.menu),
                            onPressed: () {},
                          ),
                          SizedBox(width: 110,),
                          Text(
                            "Dime",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 120,),
                          IconButton(
                            icon: CircleAvatar(
                              backgroundImage:
                                  new AssetImage('assets/namrapatel.png'),
                            ),
                            onPressed: () {},
                          ),
                        ])
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        "What would you like to do?",
                        style: titleTextStyle,
                      ),
                    ),
                    // SizedBox(
                    //   height: ,
                    // ),
                    Row(
                      children: <Widget>[
                        buildColorCard(context, "Send a Payment",
                            Icon(Icons.input), Colors.white),
                        buildColorCard(context, "Create a Dime",
                            Icon(Icons.group_add), Colors.grey[50]),
                      ],
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 15.0),
                    //   child: Divider(
                    //     color: Colors.grey,
                    //     height: 1.0,
                    //   ),
                    // ),
                  ]),
            )
          ],
        ),
      )
    ]);
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
