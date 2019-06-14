import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'classes/user.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
//  final _firestore = Firestore.instance;
//  final _auth= FirebaseAuth.instance;
//  FirebaseUser loggedInUser;



  User currentUser;
  String displayName;
//  String email;
  String bio;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
//  Future<void> getCurrentUser() async{
//    try{
//      final user= await _auth.currentUser();
//      print(user);
//      print(user.email);
//
//      if(user!=null){
//        loggedInUser=user;
//        email=loggedInUser.email;
//        print(email);
//
//      }}
//    catch(e){
//      print(e);
//    }
//  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser= new User();
    currentUser.getInfo();


//   getCurrentUser();
//   getInfo();

  }


//  void getInfo() async {
//    await getCurrentUser();
//    print("$email");
//    DocumentReference documentReference =
//    _firestore.collection("users").document("$email");
//    documentReference.get().then((DocumentSnapshot datasnapshot) {
//      if (datasnapshot.exists) {
//        String display=datasnapshot.data['display name'].toString();
//        print(display);
//      }
//      else {
//        print("No such user");
//      }
//
//    });
//
//  }





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
                      onChanged: (value){
                        displayName=value;
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
                onPressed: (){

//                  String currentEmail= loggedInUser.email;
//                  currentUser.bio=bio;
//                  currentUser.displayName=displayName;
                  currentUser.updateData(bio:bio,displayName: displayName);
                  print(currentUser.getBio());
//                  if(bio!=null) {
//                    currentUser.changeBio(bio);
//                  }
//                  if(displayName!=null) {
//                    _firestore.document('users/$currentEmail').updateData({
//                      'display name': displayName
//                    });
//                  }


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
