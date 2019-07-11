import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginpage.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  String _email="", _errorMessage;
  bool sent= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Enter an Email to reset your passwrod'),
          getUserEmail(),
          sendEmailButton(),
          _showErrorMessage(),
        ]
      )
      )
    )
    );  
  }
   Widget getUserEmail(){
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: new TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          controller: myController,
        ),
    );
  }
    Widget sendEmailButton(){
      return new RaisedButton(
        child: Text('Send'),
        color: Colors.blue,
        textColor: Colors.white,
        elevation: 7.0,
        onPressed: _showDialog,
        //Navigator.push(context, MaterialPageRoute(builder: (contect) => SignupPage()));
        
      );
  }
  Future<void> resetPassword() async {
    _email = myController.text ;
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

    resetPassword();
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
}
