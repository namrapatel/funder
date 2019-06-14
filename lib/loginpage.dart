import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funder/signuppage.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth= FirebaseAuth.instance;
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
                    decoration: InputDecoration(labelText: 'Email'),
                    onSaved: (input) => _email = input,
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    onSaved: (input) => _password = input,
                    obscureText: true, //makes the text not visible
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: signIn,
                    child: Text('Login'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,

                  ),

                  SizedBox(height: 15.0),
                  Text('Don\'t have an account?'),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    child: Text('Sign Up'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                    },
                  ),
                ],
              )),
        ));
  }
  Future<void> signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email , password: _password);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
      }catch(e){
        print(e);

      }
    }

  }

}