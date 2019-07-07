import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
              Container(
              height: 650.0,
              width: double.infinity,
            ),
          
              Container(
              height: 150.0,
              width: double.infinity,
              color: Colors.blueAccent[700],
            ),
            
            Positioned(
              top: 32,
              left: 5,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              ),
            ),
              Positioned(
              top: 98,
              left: 15,
              child: Text("Privacy Policy | Dime", style: TextStyle(color: Colors.white, fontSize: 25, ),),
            ),
              Positioned(
              top: 178,
              left: 15,
              child: Text("Privacy Policy", style: TextStyle(color: Colors.black, fontSize: 20, ),),
            ),
              Positioned(
              top: 208,
              left: 15,
              child: Text("Effective: September 1, 2019", style: TextStyle(color: Colors.grey[700], fontSize: 15, ),),
            ),


        ],
      )

    );
  }
}