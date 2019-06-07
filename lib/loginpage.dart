import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:funder/homepage.dart';
import 'package:funder/signuppage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password, _errorMessage;

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
              Text("sad"),
              TextFormField(
                validator: (input){
                  if(input.isEmpty){
                    return 'Please Try Again By Entering an Email';
                  }
                },
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (input) => _email = input, 
                  ),
              SizedBox(height: 15.0),
              TextFormField(
                validator: (input){
                  if(input.isEmpty){
                    return 'Please Try Again By Entering a Password';
                  }
                },
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
                

                //   FirebaseAuth.instance
                //       .signInWithEmailAndPassword(
                //           email: _email, password: _password)
                //       .then((FirebaseUser user) {
                //     Navigator.of(context).pushReplacementNamed('/homepage');
                //   }).catchError((e) {
                //     print(e);
                //   });
                 
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
                //Navigator.of(context).pushNamed('/signup');
                Navigator.push(context, MaterialPageRoute(builder: (contect) => SignupPage()));
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
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email , password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (contect) => HomePage()));
      }catch(e){
        print("afd");
        
        _errorMessage = e.message;
        _showErrorMessage();
      }
    }
    
  }
  Widget _showErrorMessage() {
  
  if (_errorMessage != null && _errorMessage.length > 0 ) {
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
}