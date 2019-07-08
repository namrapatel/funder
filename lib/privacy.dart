import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {

  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
              Container(
              //height: 650.0,
              height: screenH(850),
              width: double.infinity,
            ),
          
              Container(
              height: screenH(205),
              width: double.infinity,
              color: Colors.blueAccent[700],
            ),
            
            Positioned(
              top: (MediaQuery.of(context).size.height / 16),
              left: (MediaQuery.of(context).size.width / 45),
              //top: 32,
              //left: 5,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white
              ),
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 6.7),
              left: (MediaQuery.of(context).size.width / 17),
              child: Text("Privacy Policy | Dime", style: TextStyle(color: Colors.white, fontSize: 25, ),),
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 3.9),
              left: (MediaQuery.of(context).size.width / 17),
              child: Text("Privacy Policy", style: TextStyle(color: Colors.black, fontSize: 20, ),),
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 3.3),
              left: (MediaQuery.of(context).size.width / 17),
              child: Text("Effective: September 1, 2019", style: TextStyle(color: Colors.grey[700], fontSize: 15, ),),
            ),


        ],
      )

    );
  }
}