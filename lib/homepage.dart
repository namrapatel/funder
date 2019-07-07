import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'loginpage.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'screens/contactListScreen.dart';
import 'package:Dime/screens/contactListScreen.dart';

Color firstColor = Colors.greenAccent[700];
Color secondColor = Colors.greenAccent[700];
final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
final _firestore = Firestore.instance;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

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
  String uid = currentUserModel.uid;
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
      Container(
          height: screenH(260),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueAccent[400], Colors.blueAccent[700]]),
            // color: Colors.blueAccent[700],
            boxShadow: [
              BoxShadow(
                  color: Colors.blueAccent[700].withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 0.2,
                  offset: Offset(0, 7)),
            ],
          )),
      Column(children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: screenH(40),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: screenW(5),
                ),
                IconButton(
                  onPressed: () {},
                  color: Colors.white,
                  icon: Icon(Icons.menu),
                  iconSize: screenH(25.0),
                ),
                Spacer(),
                Text(
                  "Dime",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenF(20),
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                // SizedBox(width: 278),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactListScreen(),
                        ));
                  },
                  color: Colors.white,
                  icon: Icon(Icons.add),
                  iconSize: screenH(25.0),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: screenH(15)),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: screenW(20.0)),
              child: Text("Recents",
                  style: TextStyle(
                      fontSize: screenF(15), color: Colors.grey[100])),
            )),
        SizedBox(height: screenH(10)),
        Container(
          height: screenH(125),
          child: uid == null
              ? CircularProgressIndicator()
              : StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('users')
                      .document('$uid')
                      .collection('requests')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    print(uid);
                    print('wtf');
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      );
                    }
                    final docs = snapshot.data.documents;
                    List<RecentCard> recentCards = [];

                    for (var doc in docs) {
                      String requesterId = doc.data['requesterId'].toString();
                      String requesterName =
                          doc.data['requesterName'].toString();
                      String requesterPhoto =
                          doc.data['requesterPhoto'].toString();
                      print(uid);
                      print(currentUserModel.uid);
                      if (currentUserModel.uid != requesterId) {
                        recentCards.add(RecentCard(
                            personId: requesterId,
                            personName: requesterName,
                            profilePic: requesterPhoto));
                      }
                      List requestedFromIds = doc.data['requestedFromIds'];
                      List requestedFromNames = doc.data['requestedFromNames'];
                      List requestedFromPhotos =
                          doc.data['requestedFromPhotos'];
                      for (int i = 0; i < requestedFromIds.length; i++) {
                        if (currentUserModel.uid != requestedFromIds[i]) {
                          recentCards.add(RecentCard(
                              personId: requestedFromIds[i],
                              personName: requestedFromNames[i],
                              profilePic: requestedFromPhotos[i]));
                        }
                      }
                    }
                    SizedBox(height: screenH(10));
                    return Container(
                      height: screenH(165),
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                            bottom: screenH(15.0),
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: recentCards.length,
                          itemBuilder: (BuildContext context, int index) {
                            return recentCards[index];
                          }),
                    );
                  }),
        ),
      ]),
    ]);
  }
}

class RecentCard extends StatelessWidget {
  final String personId, personName, profilePic;
  RecentCard({this.personId, this.personName, this.profilePic});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: screenW(15.0)),
      child: Container(
          width: screenW(100),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: screenW(10),
                    spreadRadius: 0.2,
                    offset: Offset(3, 3)),
              ]),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: screenH(15.0)),
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(this.profilePic),
                      radius: screenW(22)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenW(12.0), vertical: screenH(15)),
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
  String uid = currentUserModel.uid;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: screenH(25)),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: screenW(20.0)),
              child: Text("Requests",
                  style: TextStyle(
                      fontSize: screenF(15), color: Colors.grey[700])),
            )),
        SizedBox(height: screenH(10)),
        Container(
            height: screenH(165),
            child: Column(
              children: <Widget>[
                uid == null
                    ? CircularProgressIndicator()
                    : StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection('users')
                            .document('$uid')
                            .collection('requests')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                            );
                          }
                          final docs = snapshot.data.documents;
                          List<RequestCard> requestCards = [];
                          for (var doc in docs) {
                            String requesterId =
                                doc.data['requesterId'].toString();
                            String requesterName =
                                doc.data['requesterName'].toString();
                            String requesterPhoto =
                                doc.data['requesterPhoto'].toString();
                            List requestedFromIds =
                                doc.data['requestedFromIds'];
                            List requestedFromNames =
                                doc.data['requestedFromNames'];
                            List requestedFromPhotos =
                                doc.data['requestedFromPhotos'];
                            String event = doc.data['event'].toString();
                            String amount = doc.data['amount'].toString();
                            String type = doc.data['type'].toString();

                            var storedDate = doc.data['timestamp'];

                            String elapsedTime =
                                timeago.format(storedDate.toDate());
                            String timestamp = '$elapsedTime';

                            requestCards.add(RequestCard(
                                requesterPhoto: requesterPhoto,
                                requesterId: requesterId,
                                requesterName: requesterName,
                                requestedFromIds: requestedFromIds,
                                requestedFromNames: requestedFromNames,
                                requestedFromPhotos: requestedFromPhotos,
                                event: event,
                                amount: amount,
                                type: type,
                                timestamp: timestamp));
                          }
                          SizedBox(height: screenH(10));
                          return Container(
                            height: screenH(165),
                            child: ListView.builder(
                                padding: EdgeInsets.only(
                                  bottom: screenH(15.0),
                                ),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: requestCards.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return requestCards[index];
                                }),
                          );
                        }),
              ],
            ))
      ],
    );
  }
}

class RequestCard extends StatelessWidget {
  final String requesterId;
  final String requesterName;
  final String requesterPhoto;
  final String amount;
  final String event;
  final String timestamp;
  final String type;
  final List requestedFromIds;
  final List requestedFromNames;
  final List requestedFromPhotos;

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
      {this.requesterId,
      this.requesterName,
      this.requesterPhoto,
      this.amount,
      this.event,
      this.timestamp,
      this.type,
      this.requestedFromIds,
      this.requestedFromNames,
      this.requestedFromPhotos});

  List<Widget> buildRequestedPhotos(List photos) {
    List<Widget> photoWidgets = [];

    for (var photo in photos) {
      photoWidgets.add(Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 1),
          child: CircleAvatar(
              backgroundImage: NetworkImage(photo), radius: screenH(10)),
        ),
        SizedBox(
          width: 5,
        )
      ]));
    }
    return photoWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: screenW(15.0)),
      child: Container(
        height: screenH(140),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.2),
                  blurRadius: screenW(8),
                  spreadRadius: 0.2,
                  offset: Offset(1, 6)),
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenW(10.0),
          ),
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
                            backgroundImage: NetworkImage(this.requesterPhoto),
                          )
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenH(10.0)),
                    child: Container(
                      height: screenH(90),
                      width: screenW(200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            event,
                            style: TextStyle(fontSize: screenF(18)),
                          ),
                          Text(timestamp,
                              style: TextStyle(
                                  fontSize: screenF(14),
                                  color: Colors.grey[600])),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: screenH(30),
                                child: ListView(
                                  padding: EdgeInsets.only(bottom: screenH(5)),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children:
                                      buildRequestedPhotos(requestedFromPhotos),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: screenW(70.0)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      color: type == 'Remind'
                                          ? Colors.greenAccent[700]
                                              .withOpacity(0.2)
                                          : type == 'Pay'
                                              ? Colors.red.withOpacity(0.2)
                                              : Colors.grey.withOpacity(0.2)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenW(8.0),
                                        vertical: screenH(3.0)),
                                    child: Text(
                                      "${type == 'Remind' ? "+" : type == 'Pay' ? "-" : ""} \$$amount",
                                      style: type == 'Remind'
                                          ? greenSubStyle
                                          : type == 'Pay'
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
                    width: screenH(140),
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {},
                      color: Colors.grey[100],
                      child: Text(type == 'Pay' ? "Message" : "Cancel"),
                      textColor: Colors.grey[700],
                    ),
                  ),
                  SizedBox(width: screenW(10)),
                  Container(
                    height: screenH(40),
                    width: screenW(120),
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      onPressed: () {},
                      color: type == 'Pay'
                          ? Colors.greenAccent[700].withOpacity(0.2)
                          : Colors.blueGrey.withOpacity(0.2),
                      textColor: type == 'Pay'
                          ? Colors.greenAccent[700]
                          : Colors.blueGrey,
                      child: Text(type),
                    ),
                  ),
                ],
              )
            ],
          ),
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
  String uid = currentUserModel.uid;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: screenW(20.0)),
                child: Text("Your Groups",
                    style: TextStyle(
                        fontSize: screenF(15), color: Colors.grey[700])),
              )),
          SizedBox(
            width: screenW(200),
          ),
          FlatButton(
            onPressed: () {},
            child: Text("VIEW ALL",
                style: TextStyle(
                    fontSize: screenF(13), color: Colors.blueAccent[700])),
          ),
        ],
      ),
      Container(
          height: screenH(270),
          child: Column(
            children: <Widget>[
              uid == null
                  ? CircularProgressIndicator()
                  : StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('users')
                          .document(uid)
                          .collection('groups')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                          );
                        }
                        final docs = snapshot.data.documents;
                        List<GroupCard> groupCards = [];
                        for (var doc in docs) {
                          String groupName = doc.data['groupName'];
                          String groupPic = doc.data['groupPic'];
                          int balanceValue = doc.data['balanceValue'];
                          int settleType = doc.data['settleType'];

                          groupCards.add(GroupCard(
                              groupName: groupName,
                              groupPic: groupPic,
                              balanceValue: balanceValue,
                              settleType: settleType));
                        }
                        SizedBox(height: screenH(10));
                        return Container(
                          height: screenH(270),
                          child: ListView.builder(
                              padding: EdgeInsets.only(
                                bottom: screenH(15.0),
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: groupCards.length,
                              itemBuilder: (BuildContext context, int index) {
                                return groupCards[index];
                              }),
                        );
                      })
            ],
          ))
    ]);
  }
}

class GroupCard extends StatelessWidget {
  final String groupName, groupPic;
  final int balanceValue, settleType;
  final greenSubStyle = TextStyle(
      color: Colors.greenAccent[700],
      fontSize: ScreenUtil(allowFontScaling: true).setSp(12.0));
  final redSubStyle = TextStyle(
      color: Colors.red,
      fontSize: ScreenUtil(allowFontScaling: true).setSp(12.0));
  final blackSubStyle = TextStyle(
      color: Colors.grey,
      fontSize: ScreenUtil(allowFontScaling: true).setSp(12.0));
  GroupCard(
      {this.groupName, this.groupPic, this.balanceValue, this.settleType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: screenW(15.0)),
      child: Container(
          width: screenW(190),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.2),
                    blurRadius: screenW(8),
                    spreadRadius: 0.2,
                    offset: Offset(0, 6)),
              ]),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                    padding: EdgeInsets.only(top: screenH(15.0)),
                    child: Container(
                      height: screenH(120),
                      child: Opacity(
                        opacity: 0.8,
                        child: ClipRRect(
                            borderRadius: new BorderRadius.circular(5.0),
                            child: Image(
                              image: NetworkImage(this.groupPic),
                            )),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenH(10)),
                child: Container(
                  width: screenW(155),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(this.groupName,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[800])),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            color: settleType == 1
                                ? Colors.greenAccent[700].withOpacity(0.2)
                                : settleType == -1
                                    ? Colors.red.withOpacity(0.2)
                                    : Colors.grey.withOpacity(0.2)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenW(8.0), vertical: screenH(3.0)),
                          child: Text(
                            "${settleType == 1 ? "+" : settleType == -1 ? "-" : ""} \$${balanceValue.toString()}",
                            style: settleType == 1
                                ? greenSubStyle
                                : settleType == -1
                                    ? redSubStyle
                                    : blackSubStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
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
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
