import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 100.0),
          CircleAvatar(
              backgroundImage: AssetImage('assets/namrapatel.png'), radius: 60.0),
              // Change AssetImage to NetworkImage and within the brackets of the
              // constructor you'll be able to place a link to the location of the image file
              // that you wish to put inside the CircleAvatar.
          SizedBox(
            height: 15.0,
          ),
          Text("Namra Patel", style: TextStyle(fontSize: 30.0, ))
        ],
      ),
    ));
  }
}
