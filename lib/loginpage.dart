import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funder/homepage.dart';
import 'package:funder/resetpasswordpage.dart';
import 'package:funder/signuppage.dart';
import 'dart:async';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email, _password, _errorMessage;
  bool loggedIn= false; 

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool checkValue = false;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getCredential();
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
              getUserEmail(),
              gertUserPassword(),
              CheckboxListTile(
                    value: checkValue,
                    onChanged: _onChanged,
                    title: new Text("Remember me"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
              SizedBox(height 15.0),
              SizedBox(height: 20.0),
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
          onEditingComplete: onEdit,
                    controller: username,
                    decoration: InputDecoration(
                        hintText: "username",
                        hintStyle: new TextStyle(color: Colors.grey.withOpacity(0.3))),
          validator: (input){
            if(input.isEmpty){
               return 'Please Try Again By Entering an Email';
            }
          },
          )
    );
  }
  Widget gertUserPassword(){
    return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
    child: new TextFormField(
      onEditingComplete: onEdit,
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "password",
                          hintStyle:
                          new TextStyle(color: Colors.grey.withOpacity(0.3)))),
      validator: (input) {
        if(input.isEmpty){
          return 'Please Try Again By Entering a Password';
          }
        },
        ),


    );

  }

  void onEdit(){
    if(username.text.length!=0) {
      _email = username.text;
    }
    if(password.text.length!=0) {
      _password = password.text;
    }
  }
  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", username.text);
      sharedPreferences.setString("password", password.text);
    });
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      print(checkValue);
      if (checkValue != null) {
        if (checkValue) {
          username.text = sharedPreferences.getString("username");
          password.text = sharedPreferences.getString("password");
          signIn();
        } else {
          username.clear();
          password.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }


Future<void> signIn() async{
    if(username.text.length!=0 && password.text.length!=0) {
      _email = username.text;
      _password = password.text;
    }
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

