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
    return Scaffold(
        body: Column(
            children: <Widget>[HomePageOne(), HomePageTwo(), HomePageThree()]));
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
      ),
    ]);
  }
}

List<RecentCard> recentsCard = [
  RecentCard("Namra", "assets/namrapatel.png"),
  RecentCard("Sean", "assets/seanmei.jpeg"),
  RecentCard("Shehab", "assets/shehabsalem.jpeg"),
  RecentCard("Taher", "assets/taher.jpeg"),
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

class HomePageTwo extends StatefulWidget {
  @override
  _HomePageTwoState createState() => _HomePageTwoState();
}

class _HomePageTwoState extends State<HomePageTwo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Requests",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700])),
            )),
        SizedBox(height: 10),
        Container(
          height: 145,
          child: ListView(
            padding: const EdgeInsets.only(
              bottom: 15.0,
            ),
            scrollDirection: Axis.horizontal,
            children: requestCards,
          ),
        )
      ],
    );
  }
}

List<RequestCard> requestCards = [
  RequestCard("Shehab Salem", "assets/shehabsalem.jpeg", "Sarah's Birthday",
      35.13, -1, -1, 4, "2m ago"),
  RequestCard("Lakers Nation", "assets/lakersnation.jpeg",
      "Saturday's Groceries", 34.99, 1, 1, 4, "17 hours ago"),
  RequestCard("Sean Mei", "assets/seanmei.jpeg", "Uber to Masonville", 4.15, -1,
      -1, 4, "2 days ago"),
];

class RequestCard extends StatelessWidget {
  final String requesterName, requesterImage, requestReason, date;
  final double requestValue, settleType, membersNumber, requestType;
  final greenSubStyle = TextStyle(
      color: Colors.greenAccent[700],
      fontSize: ScreenUtil(allowFontScaling: true).setSp(15.0));
  final redSubStyle = TextStyle(
      color: Colors.red,
      fontSize: ScreenUtil(allowFontScaling: true).setSp(15.0));
  final blackSubStyle = TextStyle(
      color: Colors.grey,
      fontSize: ScreenUtil(allowFontScaling: true).setSp(15.0));

  RequestCard(
      this.requesterName,
      this.requesterImage,
      this.requestReason,
      this.requestValue,
      this.requestType,
      this.settleType,
      this.membersNumber,
      this.date);

  @override
  Widget build(BuildContext context) {
    final screenH = ScreenUtil.instance.setHeight;
    final screenW = ScreenUtil.instance.setWidth;
    final screenF = ScreenUtil.instance.setSp;
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Container(
        height: screenH(140),
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
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenH(15.0)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: screenH(20),
                          backgroundImage: AssetImage(this.requesterImage),
                        )
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenH(10.0)),
                  child: Container(
                    height: screenH(80),
                    width: screenW(200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          requestReason,
                          style: TextStyle(fontSize: screenF(18)),
                        ),
                        Text("$date",
                            style: TextStyle(
                                fontSize: screenF(14),
                                color: Colors.grey[600])),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/namrapatel.png"),
                                radius: screenH(10)),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/shehabsalem.jpeg"),
                                radius: screenH(10)),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/seanmei.jpeg"),
                                radius: screenH(10)),
                            Padding(
                              padding: EdgeInsets.only(left: screenW(30.0)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    color: settleType == 1
                                        ? Colors.greenAccent[700]
                                            .withOpacity(0.2)
                                        : settleType == -1
                                            ? Colors.red.withOpacity(0.2)
                                            : Colors.grey.withOpacity(0.2)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenW(8.0),
                                      vertical: screenH(3.0)),
                                  child: Text(
                                    "${settleType == 1 ? "+" : settleType == -1 ? "-" : ""} \$${requestValue.toString()}",
                                    style: settleType == 1
                                        ? greenSubStyle
                                        : settleType == -1
                                            ? redSubStyle
                                            : blackSubStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: screenH(40),
                  width: screenH(115),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {},
                    color: Colors.grey[100],
                    child: Text(requestType == -1 ? "Message" : "Cancel"),
                    textColor: Colors.grey[700],
                  ),
                ),
                SizedBox(width: screenW(10)),
                Container(
                  height: screenH(40),
                  width: screenW(115),
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {},
                    color: requestType == -1
                        ? Colors.greenAccent[700].withOpacity(0.2)
                        : Colors.blueGrey.withOpacity(0.2),
                    textColor: requestType == -1
                        ? Colors.greenAccent[700]
                        : Colors.blueGrey,
                    child: Text(requestType == -1 ? "Pay Now" : "Remind"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomePageThree extends StatefulWidget {
  @override
  _HomePageThreeState createState() => _HomePageThreeState();
}

class _HomePageThreeState extends State<HomePageThree> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text("Your Groups",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                )),
            SizedBox(
              width: 170,
            ),
            FlatButton(
              onPressed: () {},
              child: Text("VIEW ALL",
                  style:
                      TextStyle(fontSize: 13, color: Colors.greenAccent[700])),
            ),
          ],
        ),
        Container(
          height: 245,
          child: ListView(
            padding: EdgeInsets.only(bottom: 15),
            scrollDirection: Axis.horizontal,
            children: groupsCard,
          ),
        )
      ],
    );
  }
}

List<GroupCard> groupsCard = [
  GroupCard("Roommates", "assets/roommates.jpeg"),
  GroupCard("Lakers Nation", "assets/lakersnation.jpeg"),
  GroupCard("Childhood Homies", "assets/childhoodhomies.jpeg"),
  GroupCard("Family", "assets/family.jpeg"),
];

class GroupCard extends StatelessWidget {
  final String personName, profilePic;
  GroupCard(this.personName, this.profilePic);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Container(
          width: 150,
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
                    child: Container(
                      height: 70,
                      width:70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.greenAccent[700].withOpacity(0.3),
                      ),
                      child: Container(
                        height:40,
                        width:40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.greenAccent[700],
                        ),
                        child: Icon(Icons.add, size: 60, color: Colors.white),
                      ),
                    )),
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
