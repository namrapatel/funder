import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/usermanagement.dart';
import 'main.dart';
import 'package:Dime/classes/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
User currentUserModel;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
bool _isLoggedIn=false;
Map userProfile;
   final _auth = FirebaseAuth.instance;
   FacebookLogin fbLogin = new FacebookLogin();

   TextEditingController _smsCodeController = TextEditingController();
   TextEditingController _phoneNumberController = TextEditingController();
   String verificationId;



  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) async{
      if(firebaseUser != null){
        print(firebaseUser);
        print(firebaseUser.displayName);
        print("you're in");

        DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(firebaseUser.uid).get();


        currentUserModel=  User.fromDocument(userRecord);
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyHomePage()));
      }
      else{
        print("floppps");
      }
    });



  }
  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(

            content: TextFormField(
              controller: _smsCodeController,
              decoration: InputDecoration(hintText: 'SMS Code'),

            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Verify'),
                onPressed: () {
                  _signInWithPhoneNumber(_smsCodeController.text);
                },
              )
            ],
          );
        });
  }

  Future<void> _sendCodeToPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential user) {
      setState(() {
        print('Inside _sendCodeToPhoneNumber: signInWithPhoneNumber auto succeeded: $user');
      });
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      setState(() {
        print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');}
      );
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationId = verificationId;
      smsCodeDialog(context).then((value) {
        print('Signed in');
      });
      print("code sent to " + _phoneNumberController.text);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _signInWithPhoneNumber(String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);
    await FirebaseAuth.instance.
    signInWithCredential(authCredential)
        .then((FirebaseUser user) async {

      final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();


      assert(user.uid == currentUser.uid);


      DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(user.uid).get();
      if(!userRecord.exists){
        Firestore.instance.collection('users').document(user.uid).setData({
          'photoUrl':'https://firebasestorage.googleapis.com/v0/b/dime-87d60.appspot.com/o/defaultprofile.png?alt=media&token=8cd5318b-9593-4837-a9f9-2a22c87463ef',
          'email': user.email,
          'displayName': 'You currently don\'t have a display name',
          'phoneNumber':user.phoneNumber
        });
      }
      print(user.uid);

      currentUserModel=  User.fromDocument(userRecord);
      print('signed in with phone number successful: user -> $user');
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyHomePage()));

    });

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Form(
//          key: _formKey,
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Login with your phone number'),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller:  _phoneNumberController,
                    validator: (input) => (input.isEmpty) ? 'Enter a valid phone number': null,
                    decoration: InputDecoration(hintText: 'Phone Number'),
                  ),

                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: _sendCodeToPhoneNumber,

                    child: Text('Log in'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,

                  ),

                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed:() async{
                      FacebookLoginResult result = await fbLogin.logInWithReadPermissions(['email','public_profile','user_friends']);




                      final FacebookAccessToken accessToken = result.accessToken;

                      AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: accessToken.token);

                      FirebaseUser user = await _auth.signInWithCredential(credential);

                      switch (result.status) {
                        case FacebookLoginStatus.loggedIn:
                          final token = result.accessToken.token;
//                          final pic =await http.get('http://graph.facebook.com/[user_id]/picture?type=square');
                          final graphResponse = await http.get('https://graph.facebook.com/v3.3/me?fields=name,picture,friends,email&access_token=${token}');
                          final profile = JSON.jsonDecode(graphResponse.body);
                          print(profile);
                          setState(() {
                            userProfile = profile;
                            _isLoggedIn = true;
                          });
                          break;

                        case FacebookLoginStatus.cancelledByUser:
                          setState(() => _isLoggedIn = false );
                          break;
                        case FacebookLoginStatus.error:
                          setState(() => _isLoggedIn = false );
                          break;
                      }

                      DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(user.uid).get();
                      if(!userRecord.exists){
                        Firestore.instance.collection('users').document(user.uid).setData({
                          'photoUrl':userProfile["picture"]["data"]["url"],
                          'email': user.email,
                          'displayName': user.displayName,
                          'phoneNumber': user.phoneNumber
                        });
                      }
                      print(user.uid);

                      currentUserModel=  User.fromDocument(userRecord);
                      print('signed in with facebook successful: user -> $user');
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyHomePage()));

                        }


                    ,

                    child: Text('Log in with Facebook'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,

                  )

                ],
              )),
        ));
  }

}