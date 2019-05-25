import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'tabBar/fancy_tab_bar.dart';
import 'tabBar/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Dashboard'),
          centerTitle: true,
        ),
        bottomNavigationBar: FancyTabBar(),
        body: Center(
          child: Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('You are now logged in'),
                SizedBox(
                  height: 15.0,
                ),
                new OutlineButton(
                  borderSide: BorderSide(
                      color: Colors.red, style: BorderStyle.solid, width: 3.0),
                  child: Text('Logout'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator
                          .of(context)
                          .pushReplacementNamed('/landingpage');
                    }).catchError((e) {
                      print(e);
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}