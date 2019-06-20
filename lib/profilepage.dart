import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'classes/user.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'editProfilePage.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User currentUser;
  String bio;
  String displayName;
  String photoUrl;
  SharedPreferences pref;

  //Initializes the state when the page first loads and retrieves the users data from firestore
  @override
  void initState() {
    super.initState();
    currentUser = new User();
    currentUser.getInfo().then((_) => setState(() {
          bio = currentUser.getBio();
          displayName = currentUser.getDisplayName();
          photoUrl= currentUser.getPhotoUrl();
          print(photoUrl);
  }));
}



  @override
  Widget build(BuildContext context) {
     double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return Container(
        child: Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 70.0,
          ),
          IconButton(
          iconSize: ScreenUtil.instance.setHeight(25.0),
          color: Colors.black,
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ));
          },
        ),
          RaisedButton(
                color: Colors.greenAccent[700],
                child: Text('Logout'),
                onPressed: () async{
                  pref = await SharedPreferences.getInstance();
                  pref.clear();
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.of(context).pushReplacementNamed('/loginpage');

                  }).catchError((e) {
                    print(e);
                  });
                }),
          SizedBox(height: 30.0),
          photoUrl==null
                ?CircularProgressIndicator()

                :CircleAvatar(
                backgroundImage: NetworkImage(photoUrl),
                radius: 150.0),
          // Change AssetImage to NetworkImage and within the brackets of the
          // constructor you'll be able to place a link to the location of the image file
          // that you wish to put inside the CircleAvatar.
          SizedBox(
            height: 15.0,
          ),
          //checks if data has been received, if not shows a progress indicator until profile is set up
          displayName == null
              ? CircularProgressIndicator()
              : Text('$displayName',
                  style: TextStyle(
                    fontSize: 30.0,
                  ))
        ],
      ),
    ));
  }
}
