import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funder/homepage.dart';
import 'package:funder/resetpasswordpage.dart';
import 'package:funder/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email="", _password, _errorMessage;
  bool loggedIn= false; 

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
              getUserEmail(),
              gertUserPassword(),
              loginButton(),
              signUpButton(),
              _showErrorMessage(),
              Text('Don\'t have an account?'),
              forgotPasswordButton(),
              Text(_email),
            ],
          )),
    ));
  }

  void saveEmail(){
    String user =  _email;
    saveUserEmailPreference(_email);
  }
  Future<bool> saveUserEmailPreference(String user) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString( "email", user);
    return pref.commit();
  }

  Future<String> getNamePreference() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String email = pref.getString("email");
    return email; 
  }
  Widget loginButton(){
      return new RaisedButton(
        onPressed: signIn,
        child: Text('Login'),
        color: Colors.blue,
        textColor: Colors.white,
        elevation: 7.0, 
      //   FirebaseAuth.instance
      //       .signInWithEmailAndPassword(
      //           email: _email, password: _password)
      //       .then((FirebaseUser user) {
      //     Navigator.of(context).pushReplacementNamed('/homepage');
      //   }).catchError((e) {
      //     print(e);
      //   });  
    );
  }
  Widget signUpButton(){
      return new RaisedButton(
        child: Text('Sign Up'),
        color: Colors.blue,
        textColor: Colors.white,
        elevation: 7.0,
        onPressed: () {
        //Navigator.of(context).pushNamed('/signup');
        Navigator.push(context, MaterialPageRoute(builder: (contect) => SignupPage()));
        },
      );
  }
  Widget forgotPasswordButton(){
    return new FlatButton(
      child: Text('Forgot Passwrod?'),
      textColor: Colors.blue,
      onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (contect) => ResetPassword()));
      },
    );
  }
  Widget getUserEmail(){
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: new TextFormField(
          
          validator: (input){
            if(input.isEmpty){
               return 'Please Try Again By Entering an Email';
            }
          },
          decoration: InputDecoration(labelText: 'Email'),
          onSaved: (input) => _email = input, 
          )
          // SizedBox(height: 15.0)
         , //           SizedBox(height: 20.0),
                    
          //           SizedBox(height: 15.0),
          
          //           SizedBox(height: 10.0),
    );
  }
  Widget gertUserPassword(){
    return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
    child: new TextFormField(
      validator: (input) {
        if(input.isEmpty){
          return 'Please Try Again By Entering a Password';
          }
        },
        decoration: InputDecoration(labelText: 'Password'),
        onSaved: (input) => _password = input, 
        obscureText: true, //makes the text not visible 
        ),

    );
  }
  Future<void> signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email , password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (contect) => HomePage()));
        saveEmail();
        setState(() {loggedIn = true;});
        user.sendEmailVerification();
      }catch(e){
        print('Error: $e');
        
        setState(() { _errorMessage = e.message;});
      
      }
    }
    
  }
  Widget _showErrorMessage() { 
    if (_errorMessage != null) {
      print(_errorMessage +"ASFDSA");
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300), 
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
  void _showDialog() {
    // flutter defined function

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Passwrod Resset"),
          content: new Text("An Email Has Been Sent to " + _email),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Return to Login"),
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (contect) => LoginPage()));
              },
            ),
          ],
        );
      }, 
    );
  }
/* 
   Future<void> verificationEmail() async {
    print(_email);
    if(_email != null){
      try{
        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        setState(() { sent = true;});
        print(sent);
        //print('sent');
      }catch(e){
        setState(() { _errorMessage = e.message;});
      }
    }else {
      print("No");
    }
  } */

}

