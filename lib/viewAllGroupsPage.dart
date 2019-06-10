import 'package:flutter/material.dart';

class ViewAllGroupsPage extends StatefulWidget {
  @override
  _ViewAllGroupsPageState createState() => _ViewAllGroupsPageState();
}

class _ViewAllGroupsPageState extends State<ViewAllGroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[homePageBottomPart],)
      
    );
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
            onPressed: () {},
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
