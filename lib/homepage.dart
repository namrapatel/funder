import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'classes/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



Color firstColor = Colors.greenAccent[700];
Color secondColor = Colors.greenAccent[700];
final screenH = ScreenUtil.instance.setHeight;
final screenW = ScreenUtil.instance.setWidth;
final screenF = ScreenUtil.instance.setSp;
final _firestore= Firestore.instance;

User currentUser;
String bio;
String displayName;
String photoUrl;
List<dynamic> myRequests;
String uid;


String requesterName;
String requesterImage;
String requestReason;
String requestValue;
double requestType;
double settleType;
double membersNumber;
String date;



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//  final _firestore= Firestore.instance;
//  User currentUser;
//  String bio;
//  String displayName;
//  String photoUrl;
//  List<String> requests;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    currentUser = new User();
//    currentUser.getInfo().then((_) => setState(() {
//      if(currentUser.getBio()!=null) {
//        bio = currentUser.getBio();
//      }
//      if(currentUser.getDisplayName()!=null) {
//        displayName = currentUser.getDisplayName();
//      }
//      if(currentUser.getPhotoUrl()!=null) {
//        photoUrl = currentUser.getPhotoUrl();
//      }
//      if(currentUser.getRequests()!=null){
//        requests=currentUser.getRequests();
//      }
//  }));
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

class _HomePageOneState extends State<HomePageOne>  {
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
        height: screenH(45),
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: screenW(5),
          ),
          IconButton(
            onPressed: () {},
            color: Colors.black,
            icon: Icon(Icons.menu),
            iconSize: screenH(25.0),
          ),
          Spacer(),
          Text(
            "Dime",
            style: TextStyle(
                color: Colors.greenAccent[700],
                fontSize: screenF(20),
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          // SizedBox(width: 278),
          IconButton(
            onPressed: () {},
            color: Colors.black,
            icon: Icon(Icons.search),
            iconSize: screenH(25.0),
          ),
        ],
      ),
      SizedBox(height: screenH(15)),
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: screenW(20.0)),
            child: Text("Recents",
                style:
                    TextStyle(fontSize: screenF(15), color: Colors.grey[700])),
          )),
      SizedBox(height: screenH(10)),
      Container(
        height: screenH(125),
        child: ListView(
          padding: EdgeInsets.only(
            bottom: screenH(15.0),
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
      padding: EdgeInsets.only(left: screenW(15.0)),
      child: Container(
          width: screenW(100),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[600].withOpacity(0.3),
                    blurRadius: screenW(10),
                    spreadRadius: 0.2,
                    offset: Offset(6, 6)),
              ]),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: screenH(15.0)),
                  child: CircleAvatar(
                      backgroundImage: AssetImage(this.profilePic),
                      radius: screenW(22)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenW(12.0), vertical: screenH(5)),
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
  void initState(){

    super.initState();
    currentUser = new User();
   currentUser.getInfo().then((_) => setState(() {
    if(currentUser.getBio()!=null) {
      bio = currentUser.getBio();

    }
    if(currentUser.getDisplayName()!=null) {
      displayName = currentUser.getDisplayName();

    }
    if(currentUser.getPhotoUrl()!=null) {
      photoUrl = currentUser.getPhotoUrl();
    }
    if(currentUser.getRequests()!=null){
      myRequests=currentUser.getRequests();
      print('homepage requests');
      print(myRequests);
    }
    if(currentUser.getUid()!=null){
      uid=currentUser.getUid();
    }}));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: screenH(10)),

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
          child:Column(
          children: <Widget>[
        myRequests==null
        ?CircularProgressIndicator()
        : StreamBuilder<QuerySnapshot> (
              stream: _firestore.collection('requests').snapshots(),
              builder: (context,snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final docs =snapshot.data.documents;
                List<RequestCard> requestCards=[];
                for(var doc in docs){
                  for(int request = 0; request < myRequests.length; request++){
                    if(doc.documentID==myRequests[request]){
                      requesterName = doc.data['requester'].toString();
                      print(requesterName);
                      requesterImage = "assets/shehabsalem.jpeg";
                      requestReason = doc.data['event'].toString();
                      print(requestReason);

                      requestValue = doc.data['amount'].toString();
                      print(requestValue);
                      requestType = 1;
                      settleType = 1;
                      membersNumber = 2;
                      date = '10m ago';
                      requestCards.add(RequestCard(
                          requesterName,
                          requesterImage,
                          requestReason,
                          requestValue,
                          requestType,
                          settleType,
                          membersNumber,
                          date));

                    }
                  }
                }
                return ListView(
                  padding: EdgeInsets.only(
                    bottom: screenH(15.0),
                  ),
                  scrollDirection: Axis.horizontal,
                  children: requestCards,
                );

//                for (int request = 0; request < myRequests.length; request++){
//                  final String requestID = myRequests[request];
//                  print(requestID);
//                  DocumentReference requestDoc = _firestore.collection("requests").document(
//                      "$requestID");
//                  print(requestDoc);
//
//                  requestDoc.get().then((DocumentSnapshot datasnapshot) {
//                    if (datasnapshot.exists) {
//                      print('exists');
//                      requesterName = datasnapshot.data['recipient'].toString();
//                      print(requesterName);
//                      requesterImage = "assets/shehabsalem.jpeg";
//                      requestReason = datasnapshot.data['event'].toString();
//                      requestValue = datasnapshot.data['amount'].toString();
//                      requestType = 1;
//                      settleType = 1;
//                      membersNumber = 2;
//                      date = '10m ago';
//                      requestCards.add(RequestCard(
//                          requesterName,
//                          requesterImage,
//                          requestReason,
//                          requestValue,
//                          requestType,
//                          settleType,
//                          membersNumber,
//                          date));
//                    }
//                  }
//                  );
//
//
//                }
              }),
            ],
        )
        )],
    );
  }
}


//List<RequestCard> requestCards = [
//  RequestCard("Shehab Salem", "assets/shehabsalem.jpeg", "Sarah's Birthday",
//      35.13, -1, -1, 4, "2m ago"),
//  RequestCard("Lakers Nation", "assets/lakersnation.jpeg",
//      "Saturday's Groceries", 34.99, 1, 1, 4, "17 hours ago"),
//  RequestCard("Sean Mei", "assets/seanmei.jpeg", "Uber to Masonville", 4.15, -1,
//      -1, 4, "2 days ago"),
//];

class RequestCard extends StatelessWidget {
  final String requesterName, requesterImage, requestReason, date,requestValue;
  final double settleType, membersNumber, requestType;
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
    return Padding(
      padding: EdgeInsets.only(left: screenW(15.0)),
      child: Container(
        height: screenH(140),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[600].withOpacity(0.3),
                  blurRadius: screenW(10),
                  spreadRadius: 0.2,
                  offset: Offset(6, 6)),
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenW(10.0),),
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
                      height: screenH(90),
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
                                padding: EdgeInsets.only(left: screenW(45.0)),
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
                    width: screenH(140),
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
                    width: screenW(120),
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
                  padding: EdgeInsets.only(left: screenW(20.0)),
                  child: Text("Your Groups",
                      style: TextStyle(
                          fontSize: screenF(15), color: Colors.grey[700])),
                )),
            SizedBox(
              width: screenW(170),
            ),
            FlatButton(
              onPressed: () {},
              child: Text("VIEW ALL",
                  style: TextStyle(
                      fontSize: screenF(13), color: Colors.greenAccent[700])),
            ),
          ],
        ),
        Container(
          height: screenH(270),
          child: ListView(
            padding: EdgeInsets.only(bottom: screenH(15)),
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
      padding: EdgeInsets.only(left: screenW(15.0)),
      child: Container(
          width: screenW(150),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[600].withOpacity(0.3),
                    blurRadius: screenW(10),
                    spreadRadius: 0.2,
                    offset: Offset(6, 6)),
              ]),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                    padding: EdgeInsets.only(top: screenH(15.0)),
                    child: Container(
                      height: screenH(70),
                      width: screenH(70),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.greenAccent[700].withOpacity(0.3),
                      ),
                      child: Container(
                        height: screenH(40),
                        width: screenW(40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.greenAccent[700],
                        ),
                        child: Icon(Icons.add,
                            size: screenH(60), color: Colors.white),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenW(12.0), vertical: screenH(7)),
                child: Text(this.personName),
              )
            ],
          )),
    );
  }
}