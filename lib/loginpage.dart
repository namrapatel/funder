import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/usermanagement.dart';
import 'signuppage.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Dime/classes/user.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

User currentUserModel;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

   final _auth = FirebaseAuth.instance;
   FacebookLogin fbLogin = new FacebookLogin();

   TextEditingController _smsCodeController = TextEditingController();
   TextEditingController _phoneNumberController = TextEditingController();
   String verificationId;


//  String _email, _password;
//
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  TextEditingController username = new TextEditingController();
//  TextEditingController password = new TextEditingController();
//
//  bool checkValue = false;
//
//  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) async{
      if(firebaseUser != null){
        print(firebaseUser);
        print("you're in");

        DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(firebaseUser.uid).get();


        currentUserModel=  User.fromDocument(userRecord);
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyHomePage()));
      }
      else{
        print("floppps");
      }
    });
//    getCredential();


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
//      AuthCredential credential = EmailAuthProvider.getCredential(email: 'idiot@hotmail.com',password: '1234567');
//      currentUser.linkWithCredential(credential).then((_){
//        print(currentUser.uid);
//
//      });

      assert(user.uid == currentUser.uid);


      DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(user.uid).get();
      if(!userRecord.exists){
        await UserManagement().storeNewUser(currentUser, context);
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
                      FacebookLoginResult result = await fbLogin.logInWithReadPermissions(['email','public_profile']);




                      final FacebookAccessToken accessToken = result.accessToken;

                      AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: accessToken.token);

                      FirebaseUser user = await _auth.signInWithCredential(credential);

                      DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(user.uid).get();
                      if(!userRecord.exists){
                        await UserManagement().storeNewUser(user, context);
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

//                  SizedBox(height: 15.0),
//                  Text('Don\'t have an account?'),
//                  SizedBox(height: 10.0),
//                  RaisedButton(
//                    child: Text('Sign Up'),
//                    color: Colors.blue,
//                    textColor: Colors.white,
//                    elevation: 7.0,
//                    onPressed: () {
//                      Navigator.push(context, MaterialPageRoute(
//                          builder: (context) => SignupPage()));
//                    },
//                  ),
                ],
              )),
        ));
  }

//  void onEdit(){
//    if(username.text.length!=0) {
//      _email = username.text;
//    }
//    if(password.text.length!=0) {
//      _password = password.text;
//    }
//  }
//  _onChanged(bool value) async {
//    sharedPreferences = await SharedPreferences.getInstance();
//    setState(() {
//      checkValue = value;
//      sharedPreferences.setBool("check", checkValue);
//      sharedPreferences.setString("username", username.text);
//      sharedPreferences.setString("password", password.text);
//    });
//  }
//
//  getCredential() async {
//    sharedPreferences = await SharedPreferences.getInstance();
//    setState(() {
//      checkValue = sharedPreferences.getBool("check");
//      print(checkValue);
//      if (checkValue != null) {
//        if (checkValue) {
//          username.text = sharedPreferences.getString("username");
//          password.text = sharedPreferences.getString("password");
//          signIn();
//        } else {
//          username.clear();
//          password.clear();
//          sharedPreferences.clear();
//        }
//      } else {
//        checkValue = false;
//      }
//    });
//  }


//  Future<void> signIn() async{
//    if(username.text.length!=0 && password.text.length!=0) {
//      _email = username.text;
//      _password = password.text;
//    }
//    final formState = _formKey.currentState;
//    if(formState.validate()){
//      formState.save();
//      try{
//        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email , password: _password);
//       FirebaseUser user =await _auth.currentUser();
//        DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(user.uid).get();
////        print(user.uid);
//        currentUserModel=  User.fromDocument(userRecord);
////        print(currentUserModel.uid);
////        print('login aove');
//        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
//      }catch(e){
////        await FirebaseAuth.instance.signInWithCredential(credential)
//        print(e);
//
//      }
//    }
//
//  }

}