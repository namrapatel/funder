import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:funder/groupsdetail.dart';
import 'package:funder/viewAllGroupsPage.dart';
import 'package:funder/widgets/colorCard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color firstColor = Colors.greenAccent[700];
Color secondColor = Colors.greenAccent[700];

class HomePage extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Scaffold(
        body: Column(
      children: <Widget>[
        HomePageTopPart(),
        HomePageBottomPart(),
      ],
    ));
  }
}

final bodyTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: "Varela",
  fontSize: ScreenUtil(allowFontScaling: true).setSp(14.0),
);
final titleTextStyle = TextStyle(
  color: Colors.grey[100],
  fontFamily: "Varela",
  fontSize: ScreenUtil(allowFontScaling: true).setSp(24.0),
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
        height: ScreenUtil.instance.setHeight(250.0),
        decoration: BoxDecoration(color: Colors.greenAccent[700]),
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil.instance.setHeight(250.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: ScreenUtil.instance.setHeight(60)),
                  // Row(
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: EdgeInsets.only(
                  //           top: ScreenUtil.instance.setHeight(40.0)),
                  //       child: Row(children: <Widget>[
                  //         SizedBox(width: ScreenUtil.instance.setWidth(25.0)),
                  //         ImageIcon(
                  //           AssetImage("assets/dimelogo1.png"),
                  //           size: ScreenUtil.instance.setHeight(33),
                  //           color: null,
                  //         ),
                  //         SizedBox(width: ScreenUtil.instance.setWidth(295)),
                  //         IconButton(
                  //           iconSize: ScreenUtil.instance.setHeight(25.0),
                  //           color: Colors.black,
                  //           icon: Icon(Icons.settings),
                  //           onPressed: () {
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                   builder: (context) => EditProfilePage(),
                  //                 ));
                  //           },
                  //         ),
                  //       ]),
                  //     )
                  //   ],
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil.instance.setWidth(17.5)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              right: ScreenUtil.instance.setWidth(15.0)),
                          child: Text(
                            "What would you like to do?",
                            style: titleTextStyle,
                          ),
                        ),
                        // SizedBox(height: ScreenUtil.instance.setHeight(0.1)),
                        InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Row(
                            children: <Widget>[
                              buildColorCard(context, "Create a Group",
                                  Icons.group_add, Colors.grey[50]),
                              buildColorCard(context, "Send a Dime", Icons.send,
                                  Colors.white),
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

var viewAllStyle = TextStyle(
    color: Colors.greenAccent[700],
    fontSize: ScreenUtil(allowFontScaling: true).setSp(14.0));
var regularBlackStyle = TextStyle(
  color: Colors.black,
  fontSize: ScreenUtil(allowFontScaling: true).setSp(18.0),
);

class HomePageBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.instance.setHeight(1.0)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: ScreenUtil.instance.setWidth(16.0)),
              Text("Your Groups", style: regularBlackStyle),
              Spacer(),
              FlatButton(
                child: Text("VIEW ALL", style: viewAllStyle),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewAllGroupsPage()),
                  );
                },
              )
            ],
          ),
        ),
        Container(
          height: ScreenUtil.instance.setHeight(510),
          child: ListView(
            children: groupCards,
            scrollDirection: Axis.vertical,
          ),
        )
      ],
    );
  }
}

List<GroupCard> groupCards = [
  GroupCard("assets/roommates.jpeg", "Roommates", 4, 59.34, -1),
  GroupCard("assets/childhoodhomies.jpeg", "Childhood Homies", 7, 178.33, 1),
  GroupCard("assets/sorority.jpeg", "Alpha Beta Phi", 44, 11.19, -1),
  GroupCard("assets/lakersnation.jpeg", "Lakers Nation", 7, 0.00, 0),
  GroupCard("assets/trip.png", "Backpacking Gang", 13, 24.09, -1),
  GroupCard("assets/family.png", "Family", 6, 0.00, 0),
];

class GroupCard extends StatelessWidget {
  final String imagePath, groupName;
  final int settleType, membersNumber;
  final double settleAmount;
  final greenSubStyle = TextStyle(
      color: Colors.greenAccent[700],
      fontSize: ScreenUtil(allowFontScaling: true).setSp(15.0));
  final redSubStyle = TextStyle(
      color: Colors.red,
      fontSize: ScreenUtil(allowFontScaling: true).setSp(15.0));
  final blackSubStyle = TextStyle(
      color: Colors.grey,
      fontSize: ScreenUtil(allowFontScaling: true).setSp(15.0));

  GroupCard(this.imagePath, this.groupName, this.membersNumber,
      this.settleAmount, this.settleType);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.instance.setWidth(4.0),
          vertical: ScreenUtil.instance.setHeight(4)),
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
            height: ScreenUtil.instance.setHeight(90.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil.instance.setHeight(3)),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GroupsDetailPage()),
                        );
                      },
                      child: ListTile(
                          leading: Container(
                            child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: AssetImage(this.imagePath)),
                          ),
                          title: Text(
                            groupName,
                            style: regularBlackStyle,
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Text("${membersNumber.toString()} members "),
                              Spacer(),
                              Container(
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
                                      horizontal:
                                          ScreenUtil.instance.setWidth(8.0),
                                      vertical:
                                          ScreenUtil.instance.setHeight(3.0)),
                                  child: Text(
                                    "${settleType == 1 ? "+" : settleType == -1 ? "-" : ""} \$${settleAmount.toString()}",
                                    style: settleType == 1
                                        ? greenSubStyle
                                        : settleType == -1
                                            ? redSubStyle
                                            : blackSubStyle,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
