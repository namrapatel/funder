import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funder/screens/InvitesScreen.dart';
import 'package:funder/screens/WorldwideScreen.dart';
import 'screens/WorldwideScreen.dart';
import 'screens/InvitesScreen.dart';

class WorldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[WorldPageOne()],
    ));
  }
}

class WorldPageOne extends StatefulWidget {
  @override
  _WorldPageOneState createState() => _WorldPageOneState();
}

class _WorldPageOneState extends State<WorldPageOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        SizedBox(
          height: 45,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 17,
            ),
            Text(
              "Your World",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              color: Colors.black,
              icon: Icon(Icons.create),
              iconSize: 25.0,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        DefaultTabController(
          length: 2,
          child: TabBar(
            indicatorColor: Colors.blueAccent[700],
            tabs: <Widget>[
              Tab(
                child: Text("Worldwide", style: TextStyle(color: Colors.black)),
                icon: Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                // text: "Worldwide",
              ),
              Tab(
                icon: Icon(Icons.inbox, color: Colors.black),
                child: Text("Invites", style: TextStyle(color: Colors.black)),
              )
            ],
          ),
        )
      ]),
    );
  }
}
