import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Creates a document in the database for each user, differentiated by email

class UserManagement {
  storeNewUser(user, context) {
    FirebaseUser current= user;
    String currentEmail= current.email;
    Firestore.instance.collection('users').document('$currentEmail').setData({
      'uid': current.uid,
      'display name': current.displayName
    });
  }
}