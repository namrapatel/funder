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
        // height: 600.0,
        // decoration: BoxDecoration(
        //   color: Colors.white
        //   // gradient: LinearGradient(
        //   //   colors: [firstColor, secondColor],
        //   // ),
        // ),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 440.0,
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
                            icon: CircleAvatar(
                              backgroundImage:
                                  new AssetImage('assets/namrapatel.png'),
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Namra Patel",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 120.0,
                          ),
                          IconButton(
                            iconSize: 25.0,
                            color: Colors.black,
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          IconButton(
                            iconSize: 25.0,
                            color: Colors.black,
                            icon: Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        ])
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        buildColorCard(context, "Pending", 354.17, 1,
                            Colors.blueAccent[700]),
                        buildColorCard(
                            context, "Unpaid", 76.09, -1, Color(0xFFff3f5e))
                      ],
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Divider(
                        color: Colors.grey,
                        height: 1.0,
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.black.withOpacity(0.2),
                            //       blurRadius: 16,
                            //       spreadRadius: 0.2,
                            //       offset: Offset(0, 8)),
                            // ]),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "What would you like to do?",
                                    style: titleTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.input),
                                            iconSize: 40.0,
                                            color: Colors.greenAccent[700]),
                                        Text(
                                          "Send a Payment",
                                          style: bodyTextStyle,
                                        ),
                                      ],
                                    ),
                                    // VerticalDivider(
                                    //   color: Colors.black,
                                    //   width: 2.0,
                                    // ),
                                    Column(
                                      children: <Widget>[
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.call_split),
                                            iconSize: 40.0,
                                            color: Colors.greenAccent[700]),
                                        Text(
                                          "Create a Dime",
                                          style: bodyTextStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
