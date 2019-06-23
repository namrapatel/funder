import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Creates a document in the database for each user, differentiated by email

class UserManagement {
  storeNewUser(user, context) {

    FirebaseUser current= user;
    String uid= current.uid;
    Firestore.instance.collection('users').document('$uid').setData({
      'email': current.email,
      'display name': 'You currently don\'t have a display name'
    });
  }
}