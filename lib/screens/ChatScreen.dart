import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funder/homepage.dart';

class GroupsChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => GroupsDetailPage()),
          // );
        },
        child: ListView(
          children: requestCards,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}

List<RequestCard> requestCards = [
  RequestCard("Shehab Salem", "assets/shehabsalem.jpeg", "Sarah's Birthday",
      35.13, -1, -1, 4, "August 9th, 2019"),
  RequestCard("Namra Patel", "assets/namrapatel.png", "Saturday's Groceries",
      34.99, 1, 1, 4, "August 7th, 2019"),
  RequestCard("Sean Mei", "assets/seanmei.jpeg", "Uber to Masonville", 4.15, -1,
      -1, 4, "June 30th, 2019"),
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
        padding: EdgeInsets.symmetric(
            vertical: screenH(10.0), horizontal: screenW(10)),
        child: Container(
          height: screenH(140),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
                      width: screenW(310),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            requestReason,
                            style: TextStyle(fontSize: 18),
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
                                      horizontal: screenW(8.0),
                                      vertical: screenH(2.0)),
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
                    width: screenH(180),
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {},
                      color: Colors.grey[100],
                      child: Text("Cancel"),
                    ),
                  ),
                  SizedBox(width: screenW(10)),
                  Container(
                    height: screenH(40),
                    width: screenW(180),
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {},
                      color: requestType == -1
                          ? Colors.greenAccent[700]
                          : Colors.blueGrey,
                      textColor: Colors.white,
                      child: Text(requestType == -1 ? "Pay" : "Remind"),
                    ),
                  ),
                  SizedBox(
                    height: screenH(20),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
