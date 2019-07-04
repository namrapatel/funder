import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'classes/user.dart';
import 'loginpage.dart';
import 'services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _smsCodeController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String verificationId;

  /// Sends the code to the specified phone number.
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
      AuthCredential credential = EmailAuthProvider.getCredential(email: 'idiot@hotmail.com',password: '1234567');
      currentUser.linkWithCredential(credential).then((_){
        print(currentUser.uid);

      });
      
      assert(user.uid == currentUser.uid);
      DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(user.uid).get();
      print(user.uid);
      await UserManagement().storeNewUser(currentUser, context);
      currentUserModel=  User.fromDocument(userRecord);
      print('signed in with phone number successful: user -> $user');
      Navigator.of(context).pushReplacementNamed('/homepage');

    });

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                      validator: (input) => (input.isEmpty||!input.contains('@')) ? 'Please enter a valid email': null,
                      decoration: InputDecoration(hintText: 'Email'),
                      onSaved: (value) {
                        setState(() {
                          _email = value;
                        });
                      }),
                  SizedBox(height: 15.0),
                  TextFormField(
                      validator: (input) => (input.isEmpty||input.length<6) ? 'Your password needs at least 6 characters': null,
                      decoration: InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      onSaved: (value) {
                        setState(() {
                          _password = value;
                        });
                      }),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text('Sign Up'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: createUser,
                  ),
                  new TextField(
                    controller:  _phoneNumberController,
                  ),
                  new TextField(
                    controller: _smsCodeController,
                  ),
                  new FlatButton(
                      onPressed: () => _signInWithPhoneNumber(_smsCodeController.text),
                      child: const Text("Sign In"))
                ],
              )),
        ),
        floatingActionButton: new FloatingActionButton(
        onPressed: () => _sendCodeToPhoneNumber(),
    tooltip: 'get code',
    child: new Icon(Icons.send),
    ) // This trailing comma makes auto-formatting nicer for build methods.);
    );}
  void createUser() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email , password: _password)
            .then((signedInUser){
          UserManagement().storeNewUser(signedInUser, context);

        });
//        user.sendEmailVerification();
        Navigator.of(context).pop(); //closes the page
      }catch(e){
        print(e.message);

      }
    }
  }
}