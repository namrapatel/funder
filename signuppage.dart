import 'package:flutter/material.dart';
import 'package:funder/loginpage.dart';

//services
import 'services/usermanagement.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email="", _password='', _password2='', _errorMessage;
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
                    getUserPassword(),
                    getUserPassword2(),
                    signUpButton(),
                    printError(),
                    printDNM(),
                    Text(_email),
  
                    //SizedBox(height: 15.0),
                    
                    //SizedBox(height: 20.0),
                    
                        //FirebaseAuth.instance
                          //  .createUserWithEmailAndPassword(email: _email, password: _password)
                            //then((signedInUser) {
                          //UserManagement().storeNewUser(signedInUser, context);
                        //}).catchError((e) {
                       //  print(e);
                       // });
                  
                   
                  ],
                )),
      ));
    }
    Widget getUserEmail(){
      return Padding( 
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextFormField(
          decoration: InputDecoration(hintText: 'Email'),
          onSaved: (value) {
            setState(() {
              _email = value;
            });
            print(_email);
          }),
      );
    }
    Widget getUserPassword(){
      return Padding( 
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: 'Password'),
            onSaved: (value) {
              setState(() {
                _password = value;
                        });
          }),
      );
    }

    Widget getUserPassword2(){
      return Padding( 
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: 'Re-Enter Password'),
            onSaved: (value) {
              setState(() {
                _password2 = value;
                        });
          }),
      );
    }
    Widget signUpButton(){
        return new RaisedButton(
          child: Text('Create Account'),
          onPressed: _showDialog, 
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 7.0,
          
        );
    }
  
    Widget printDNM(){
      if(_password != _password2){
      return new Text(
        "Passwords do not match",
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    }else{
      return new Container(
        height: 0.0,
      );
      }
    }

    Widget printError(){
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
    Future <void> createUser() async{
      final formState = _formKey.currentState;
     
        if(formState.validate()){
          print('user creatred');
          formState.save();
          try{
            setState(() { _errorMessage = "";});
             FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email , password: _password);
            user.sendEmailVerification();
            Navigator.of(context).pop(); //closes the page
            //Navigator.pushReplacment(context, MaterialPageRoute(builder: (contect) => HomePage()));
            
          }catch(e){ 
            setState(() { _errorMessage = e.message;});
            print("error");
          }
      }
    }
    void _showDialog() {
    // flutter defined function
    createUser();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Account Created"),
          content: new Text("A Verification Email Has Been Sent to " + _email),
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
  }
  
  