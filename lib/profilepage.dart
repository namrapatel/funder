import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'loginpage.dart';
import 'classes/user.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  User currentUser;
  String bio;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser= new User();
    currentUser.getInfo().then((_) =>setState(() { bio = currentUser.getBio();  }));

  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(

                  color: Colors.red,

                  child: Text('Logout'),
                  onPressed: (){
                    FirebaseAuth.instance.signOut().then((value){
                      Navigator.of(context).pushReplacementNamed('/loginpage');
                    }).catchError((e){
                      print(e);
                    }

                    );}
              ),
              SizedBox(height: 100.0),
              CircleAvatar(
                  backgroundImage: AssetImage('assets/namrapatel.png'), radius: 60.0),
              // Change AssetImage to NetworkImage and within the brackets of the
              // constructor you'll be able to place a link to the location of the image file
              // that you wish to put inside the CircleAvatar.
              SizedBox(
                height: 15.0,
              ),
              bio==null
                  ? CircularProgressIndicator()
                  :Text('$bio', style: TextStyle(fontSize: 30.0, ))
            ],
          ),
        ));
  }
}
