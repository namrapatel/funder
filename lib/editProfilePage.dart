import 'package:flutter/material.dart';
import 'classes/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User currentUser;
  String displayName;
  String bio;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  //Gets the info from database of the current user when page loads
  @override
  void initState() {
    super.initState();
    currentUser = new User();
    currentUser.getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/dimewhite.png'),
            radius: 50.0,
          ),
        ),
        FlatButton(
            //TODO: get the change picture functionality working
            onPressed: () {
              //changeProfilePhoto(context);
            },
            child: Text(
              "Change Photo",
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                  onChanged: (value) {
                    displayName = value;
                  },
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "Username",
                  )),
              TextField(
                  onChanged: (value) {
                    bio = value;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "bio",
                  )),
            ],
          ),
        ),
        RaisedButton(
            //Updates the user's profile changes to Firestore and User class
            onPressed: () {
              currentUser.updateData(bio: bio, displayName: displayName);
              Navigator.pop(context);
            },
            child: Text("Back"))
      ],
    ));
  }

  Widget buildTextField({String name, TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            name,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: name,
          ),
        ),
      ],
    );
  }
}
