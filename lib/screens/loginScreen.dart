import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.dstATop),
                  image: AssetImage("assets/dimeloginbackground.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                WelcomeSection(),
                MobileSection(),
                MediaSection()
              ],
            )));
  }
}

class WelcomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 100.0,
        ),
        Container(
          height: 60.0,
          width: 95.0,
          child: Image.asset(
            'assets/dimelogo.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Welcome,',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        Text(
          'get started with dime',
          style: TextStyle(color: Colors.white70, fontSize: 30),
        )
      ],
    ));
  }
}

class MobileSection extends StatefulWidget {
  @override
  _MobileSectionState createState() => _MobileSectionState();
}

class _MobileSectionState extends State<MobileSection> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 80,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            // Text(
            //   'Phone number',
            //   style: TextStyle(color: Colors.white, fontSize: 22),
            // ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Theme(
                data: new ThemeData(
                    primaryColor: Colors.white,
                    accentColor: Colors.white,
                    hintColor: Colors.white),
                child: TextField(
                  onChanged: (text) {},
                  decoration: InputDecoration(
                      labelText: 'Phone number',
                      labelStyle: TextStyle(fontSize: 30, color: Colors.white),
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white))),
                  style: TextStyle(fontSize: 20, color: Colors.white,),
                  cursorColor: Colors.white,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          height: 40,
          width: 350,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 16,
                  spreadRadius: 0.2,
                  offset: Offset(0, 8)),
            ],
          ),
          child: RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            onPressed: () {},
            color: Colors.black,
            textColor: Colors.white,
            child: Text(
              'Continue',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'By clicking Continue you agree',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 1.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 110,
            ),
            Text(
              'to our ',
              style: TextStyle(color: Colors.white),
            ),
            InkWell(
              onTap: () {

              },
              child: Text(
                'Terms of Service',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}

class MediaSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 180,
          ),
          Text(
            'Connect using a social account:',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Container(
            height: 40,
            width: 350,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 16,
                    spreadRadius: 0.2,
                    offset: Offset(0, 8)),
              ],
            ),
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {},
              color: Colors.blue[900],
              textColor: Colors.white,
              child: Text(
                'Facebook',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
