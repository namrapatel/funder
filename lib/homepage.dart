import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color firstColor = Colors.greenAccent[700];
Color secondColor = Colors.greenAccent[700];

class HomePage extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: <Widget>[HomePageOne()]));
  }
}

class HomePageOne extends StatefulWidget {
  @override
  _HomePageOneState createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> {
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Column(children: <Widget>[
      SizedBox(
        height: 45,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 17,
          ),
          Text(
            "Hello Namra",
            style: TextStyle(
                color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          // SizedBox(width: 278),
          IconButton(
            onPressed: () {},
            color: Colors.black,
            icon: Icon(Icons.search),
            iconSize: 25.0,
          ),
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Recents",
                style: TextStyle(fontSize: 15, color: Colors.grey[700])),
          )),
      SizedBox(height: 10),
      Container(
        height: 110,
        child: ListView(
          padding: const EdgeInsets.only(
            bottom: 20.0,
          ),
          scrollDirection: Axis.horizontal,
          children: recentsCard,
        ),
      )
    ]);
  }
}

List<RecentCard> recentsCard = [
  RecentCard("Namra", "assets/namrapatel.png"),
  RecentCard("Sean", "assets/seanmei.jpeg"),
  RecentCard("Shehab", "assets/shehabsalem.jpeg"),
  RecentCard("Namra", "assets/namrapatel.png"),
  RecentCard("Sean", "assets/seanmei.jpeg"),
  RecentCard("Shehab", "assets/shehabsalem.jpeg")
];

class RecentCard extends StatelessWidget {
  final String personName, profilePic;
  RecentCard(this.personName, this.profilePic);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Container(
          width: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[600].withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 0.2,
                    offset: Offset(6, 6)),
              ]),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: CircleAvatar(
                      backgroundImage: AssetImage(this.profilePic), radius: 20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
                child: Text(this.personName),
              )
            ],
          )),
    );
  }
}
