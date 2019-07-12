import 'package:Dime/groupsdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;

class TransactionDetail extends StatefulWidget {
  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  final String requestType = "remind";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: screenH(896),
          width: screenW(440),
          color: Colors.black,
          child: Column(
            children: <Widget>[
              SizedBox(height: screenH(70)),
              Container(
                  height: screenH(630),
                  width: screenW(340),
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.white.withOpacity(0.5),
                      //       blurRadius: screenH(20),
                      //       spreadRadius: screenH(5),
                      //       offset: Offset(0, 5)),
                      // ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(screenH(20.0)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Ivey Business Case Comp",
                              style: TextStyle(
                                  fontSize: screenF(20),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenW(20.0)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: screenH(5.0)),
                                          child: Text(
                                            "CREATED BY",
                                            style: TextStyle(
                                                fontSize: screenF(14),
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          "Namra Patel",
                                          style: TextStyle(
                                              fontSize: screenF(16),
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "(587)-703-9807",
                                          style: TextStyle(
                                              fontSize: screenF(14),
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: screenW(25.0)),
                                      child: CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/namrapatel.png'),
                                        radius: screenH(26),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenH(32),
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "DATE",
                                          style: TextStyle(
                                              fontSize: screenF(14),
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "August 9th, 2019",
                                          style: TextStyle(
                                              fontSize: screenF(14),
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: screenW(25.0)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "TIME",
                                            style: TextStyle(
                                                fontSize: screenF(14),
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "9:41 PM",
                                            style: TextStyle(
                                                fontSize: screenF(14),
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenH(20)),
                        Padding(
                          padding: EdgeInsets.only(right: screenW(20.0)),
                          child: Divider(
                            indent: screenW(20),
                            color: Colors.grey[700],
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          height: screenH(5),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenW(20.0)),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Participants",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        Container(
                            height: screenH(220),
                            width: screenW(300),
                            // decoration: BoxDecoration(
                            //     color: Colors.transparent,
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.black.withOpacity(0.25),
                            //         offset: const Offset(0.0, 0.0),
                            //       ),
                            //       BoxShadow(
                            //         color: Colors.grey[300],
                            //         offset: const Offset(0.0, 0.0),
                            //         spreadRadius: -12.0,
                            //         blurRadius: 12.0,
                            //       ),
                            //     ],
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(15))),
                            child: ListView(
                                padding: EdgeInsets.all(0),
                                children: splitsCard)),
                        SizedBox(
                          height: screenH(10),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: screenW(175.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Total Requested",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenF(15))),
                                  Text("500.00",
                                      style: TextStyle(
                                          color: Colors.redAccent[700],
                                          fontSize: screenF(15))),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Total Paid",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenF(15))),
                                  Text("500.00",
                                      style: TextStyle(
                                          color: Colors.greenAccent[700],
                                          fontSize: screenF(15))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenH(15),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: screenH(40),
                              width: screenH(130),
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                                onPressed: () {},
                                color: Colors.grey[100],
                                child: Text("Cancel"),
                              ),
                            ),
                            SizedBox(width: screenW(30)),
                            Container(
                              height: screenH(40),
                              width: screenW(130),
                              child: FlatButton(
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0)),
                                onPressed: () {},
                                color: requestType == "remind"
                                    ? Colors.black
                                    : Colors.blueGrey,
                                textColor: Colors.white,
                                child: Text(
                                    requestType == "remind" ? "Pay" : "Remind"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: screenH(20),
              ),
              Container(
                decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.white.withOpacity(0.5),
                  //       blurRadius: screenH(10),
                  //       spreadRadius: screenH(0.2),
                  //       offset: Offset(0, 4)),
                  // ],
                ),
                height: 40,
                width: 310,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  color: Colors.white,
                  child: Text("DONE"),
                  onPressed: () {
                    Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new GroupsDetailPage()));
                  },
                ),
              )
              // IconButton(
              //   icon: Icon(Icons.cancel),
              //   color: Colors.white,
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   iconSize: screenH(60),
              // )
            ],
          ),
        )
      ]),
    );
  }
}

List<SplitsCard> splitsCard = [
  SplitsCard(
      personName: "Shehab Salem",
      personPic: "assets/shehabsalem.jpeg",
      phoneNumber: "(587)-703-9807",
      paidValue: "-49.40",
      status: "1"),
  SplitsCard(
      personName: "Dhruv Patel",
      personPic: "assets/dhruvpatel.jpeg",
      phoneNumber: "(587)-703-9807",
      paidValue: "-10.81",
      status: "-1"),
  SplitsCard(
      personName: "Taher Anky",
      personPic: "assets/taher.jpeg",
      phoneNumber: "(587)-703-9807",
      paidValue: "-19.99",
      status: "-1")
];

class SplitsCard extends StatelessWidget {
  final String personName, personPic, phoneNumber, paidValue, status;

  SplitsCard(
      {this.personName,
      this.personPic,
      this.phoneNumber,
      this.paidValue,
      this.status});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: screenH(20.0)),
      child: Container(
          height: screenH(50),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    status == "1" ? Icons.done : Icons.hourglass_empty,
                    color: status == "1"
                        ? Colors.greenAccent[700]
                        : Colors.redAccent[700],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenW(8.0)),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(this.personPic),
                      radius: screenH(19),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: screenW(12.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(this.personName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: screenF(16))),
                        SizedBox(
                          height: screenH(2),
                        ),
                        Text(this.phoneNumber,
                            style: TextStyle(
                                color: Colors.black, fontSize: screenF(12))),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: screenW(20.0)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: status == "1"
                              ? Colors.red.withOpacity(0.2)
                              : Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenH(2.0), horizontal: screenW(8.0)),
                        child: Text(
                          this.paidValue,
                          style: TextStyle(
                              color: status == "1" ? Colors.red : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
