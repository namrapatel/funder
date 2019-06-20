import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funder/resetpasswordpage.dart';
class Screen extends StatefulWidget {
  @override
  _Screen createState() => _Screen();
}


class _Screen extends State<Screen>{


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
@override
Widget build(BuildContext context) {
  return new Scaffold(
    backgroundColor: Colors.white.withOpacity(0.50), 
    body: Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              okButton(),
        ]
      ),
    ),
    ),
  );
}
Widget okButton(){
  return FlatButton(
    child: Text("OK"),
    //onPressed : 
  );
}
/*
Widget 

showAlertDialog(BuildContext context) {
 
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("My title"),
    content: Text("This is my message."),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  */
}



