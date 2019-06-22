import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funder/signuppage.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String _email, _password;

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
                  new TextFormField(
                    onEditingComplete: onEdit,
                    controller: username,
                    decoration: InputDecoration(
                        hintText: "username",
                        hintStyle: new TextStyle(color: Colors.grey.withOpacity(0.3))),
                  ),
                  new TextFormField(
                      onEditingComplete: onEdit,
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "password",
                          hintStyle:
                          new TextStyle(color: Colors.grey.withOpacity(0.3)))),
                  new CheckboxListTile(
                    value: checkValue,
                    onChanged: _onChanged,
                    title: new Text("Remember me"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(height: 15.0),
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
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignupPage()));
                    },
                  ),
                ],
              )),
        ));
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
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email , password: _password);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
      }catch(e){
        print(e);

      }
    }

  }

}