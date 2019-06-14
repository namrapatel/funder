import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funder/homepage.dart';
import 'package:flutter/widgets.dart';

class UserManagement {
  storeNewUser(user, context) {
    FirebaseUser current= user;
    String currentEmail= current.email;
    Firestore.instance.collection('users').document('$currentEmail').setData({
      'uid': current.uid,
      'display name': current.displayName
    });
//    Firestore.instance.collection('users').add({
//      'email': user.email,
//      'uid': user.uid
//    }).then((value) {
//      Navigator.of(context).pop();
//      Navigator.of(context).pushReplacementNamed('/homepage');
//    }).catchError((e) {
//      print(e);
//    });
  }
}