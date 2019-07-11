import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupMembersSection extends StatefulWidget {
  @override
  _GroupMembersSection createState() => _GroupMembersSection();
}

class _GroupMembersSection extends State<GroupMembersSection> {
  
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

    return Stack(children: <Widget>[
      Column(children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Text(
              'To whom?',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: (105),
          child: ListView(
            padding: EdgeInsets.only(
              bottom: (15.0),
            ),
            scrollDirection: Axis.horizontal,
            children: requestFrom,
          ),
        ),
      ]),
    ]);
  }
}

List<GroupCard> requestFrom = [
  GroupCard("Namra", "assets/namrapatel.png", 0),
  GroupCard("Sean", "assets/seanmei.jpeg", 0),
  GroupCard("Shehab", "assets/shehabsalem.jpeg", 0),
  GroupCard("Taher", "assets/taher.jpeg", 0),
  GroupCard("Sean", "assets/seanmei.jpeg", 0),
  GroupCard("Shehab", "assets/shehabsalem.jpeg", 0)
];

class GroupCard extends StatelessWidget {
  String personName, profilePic;
  int individualValue;
  GroupCard(this.personName, this.profilePic, this.individualValue);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: (12.0)),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: Colors.black.withOpacity(0.05),
          ),
          width: 80,
          height: 500.0,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                      backgroundImage: AssetImage(this.profilePic),
                      radius: (22)),
                  SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: Text(
                      this.personName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
