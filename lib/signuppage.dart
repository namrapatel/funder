import 'package:flutter/material.dart';
import 'services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                ],
              )),
        ));
  }
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