import 'package:flutter/material.dart';
import 'package:funder/widgets/colorCard.dart';
import 'package:funder/ui/CustomShapeClipper.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color firstColor = Colors.greenAccent[400];
Color secondColor = Colors.greenAccent[700];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[HomePageTopPart()],
    ));
  }
}

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
      ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 400.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [firstColor, secondColor],
              ),
            ),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                left: 20,
                top: 70,
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row( children: <Widget>[
                    CircleAvatar(
                      backgroundImage: new AssetImage('assets/namrapatel.png'),
                    ),
                    SizedBox(width: 10.0,),
                    // Padding(padding: EdgeInsetsGeometry,)
                    Text(
                      "Namra Patel",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 125.0,),
                    IconButton(
                      iconSize: 25.0,
                      color: Colors.white,
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                     IconButton(
                      iconSize: 25.0,
                      color: Colors.white,
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ])],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildColorCard(
                        context, "Pending", 35.17, 1, Colors.blueAccent[700]),
                    buildColorCard(
                        context, "Unpaid", 4978, -1, Color(0xFFff3f5e))
                  ],
                ),
              ],
            ),
          ))
    ]);
  }
}
