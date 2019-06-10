import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:funder/viewAllGroupsPage.dart';
import 'package:funder/widgets/colorCard.dart';
import 'editProfilePage.dart';

Color firstColor = Colors.greenAccent[700];
Color secondColor = Colors.greenAccent[700];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: BottomBar(),
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
                          ImageIcon(
                            AssetImage("assets/dimelogo1.png"),
                            size: 33,
                            color: null,
                          ),
                          // Text(
                          //   "Dime",
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 22,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          SizedBox(
                            width: 295,
                          ),
                          IconButton(
                            iconSize: 25.0,
                            color: Colors.black,
                            icon: Icon(Icons.settings),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProfilePage(),
                                  ));
                            },
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
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 16.0,
          ),
          Text("Your Groups", style: regularBlackStyle),
          Spacer(),
          FlatButton(
            child: Text("VIEW ALL", style: viewAllStyle),
            onPressed: () {
              // Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                       builder: (context) => EditProfilePage(),
              //                     ));
            },
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
  GroupCard("assets/roommates.jpeg", "Roommates", 4, 59.34, -1),
  GroupCard("assets/childhoodhomies.jpeg", "Childhood Homies", 7, 178.33, 1),
  GroupCard("assets/sorority.jpeg", "Alpha Beta Phi", 44, 11.19, -1),
  GroupCard("assets/lakersnation.jpeg", "Lakers Nation", 7, 0.00, 0),
  GroupCard("assets/trip.png", "Backpacking Gang", 13, 24.09, -1),
  GroupCard("assets/family.png", "Family", 6, 0.00, 0),
];

class GroupCard extends StatelessWidget {
  final String imagePath, groupName;
  final int settleType;
  final double settleAmount;
  final int membersNumber;
  final greenSubStyle =
      TextStyle(color: Colors.greenAccent[700], fontSize: 15.0);
  final redSubStyle = TextStyle(color: Colors.red, fontSize: 15.0);
  final blackSubStyle = TextStyle(color: Colors.grey, fontSize: 15.0);

  GroupCard(this.imagePath, this.groupName, this.membersNumber,
      this.settleAmount, this.settleType);

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
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: settleType == 1
                              ? Colors.greenAccent[700].withOpacity(0.2)
                              : settleType == -1
                                  ? Colors.red.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Text(
                          "${settleType == 1 ? "+" : settleType == -1 ? "-" : ""} \$${settleAmount.toString()}",
                          style: settleType == 1
                              ? greenSubStyle
                              : settleType == -1 ? redSubStyle : blackSubStyle,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        )
      ]),
    );
  }
}
