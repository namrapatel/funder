import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "Username",
                  )),
                   TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                  )),
            ],
          ),
        ),
        RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back"))
        // Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: MaterialButton(onPressed: () => {}, child: Text("Logout")))
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
