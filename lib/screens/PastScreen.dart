import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: ListView(
          padding: EdgeInsets.all(0),
          children: pastCards,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}

List<PastCard> pastCards = [
  PastCard("Shehab Salem", "assets/shehabsalem.jpeg", "July Netflix", 3.14, -1,
      -1, 4, "July 26th, 2019"),
  PastCard("Namra Patel", "assets/namrapatel.png", "Ivey Case Comp Tickets",
      40.00, 1, 1, 4, "July 22nd, 2019"),
  PastCard("Dhruv Patel", "assets/dhruvpatel.jpeg", "Chegg Subscription", 4.15, -1,
      -1, 4, "July 16th, 2019"),
  PastCard("Dhruv Patel", "assets/dhruvpatel.jpeg", "ViaRail to the 6ix", 54.34, -1,
      -1, 4, "July 10th, 2019"),
  PastCard("Namra Patel", "assets/namrapatel.png", "Metro Run", 14.19, 1, 1, 4,
      "July 6th, 2019"),
  PastCard("Shehab Salem", "assets/shehabsalem.jpeg", "June Netflix", 3.14, -1,
      -1, 4, "June 26th, 2019"),
];

class PastCard extends StatelessWidget {
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

  PastCard(
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
    return Row(children: <Widget>[
      Expanded(
        child: Container(
          height: ScreenUtil.instance.setHeight(103.0),
          decoration: new BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: ScreenUtil.instance.setHeight(100),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil.instance.setHeight(15)),
                  child: GestureDetector(
                    onTap: () {},
                    child: ListTile(
                        trailing: IconButton(
                          icon: Icon(
                            Icons.navigate_next,
                            size: ScreenUtil.instance.setHeight(30),
                          ),
                          onPressed: () {},
                        ),
                        leading: Container(
                          width: ScreenUtil.instance.setWidth(40),
                          height: ScreenUtil.instance.setHeight(110),
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                  radius: ScreenUtil.instance.setHeight(20),
                                  backgroundImage:
                                      AssetImage(this.requesterImage)),
                            ],
                          ),
                        ),
                        title: Text(
                          requestReason,
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("$date",
                                    style: TextStyle(
                                        fontSize:
                                            ScreenUtil.instance.setSp(14))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/namrapatel.png"),
                                    radius: ScreenUtil.instance.setHeight(10)),
                                SizedBox(
                                  width: ScreenUtil.instance.setWidth(5),
                                ),
                                CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/shehabsalem.jpeg"),
                                    radius: ScreenUtil.instance.setHeight(10)),
                                SizedBox(
                                  width: ScreenUtil.instance.setWidth(5),
                                ),
                                CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/dhruvpatel.jpeg"),
                                    radius: ScreenUtil.instance.setHeight(10)),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
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
                                            ScreenUtil.instance.setHeight(2.0)),
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
                              ],
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
    ]);
  }
}