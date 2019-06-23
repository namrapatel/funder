import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'classes/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User currentUser;
  String displayName;
  String bio;
  File _image;
  String url;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();


  Future<void> setImage() async {
   var sampleImage = await ImagePicker.pickImage(source: ImageSource.gallery);

setState(() {
  _image = sampleImage;
});
  }

  //Gets the info from database of the current user when page loads
  @override
  void initState() {
    super.initState();

    currentUser= new User();
    currentUser.getInfo().then((_) => setState(() {
      bio = currentUser.getBio();
      displayName = currentUser.getDisplayName();
      url= currentUser.getPhotoUrl();
    }));
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
              child:
                  currentUser.getPhotoUrl()== null
                  ? Text('You currently have no profile picture')//call set image which sets it on the current page and also sends to firestore,
                  : CircleAvatar(
                      backgroundImage: NetworkImage(currentUser.getPhotoUrl()),
                      radius: 75.0),

            ),
            FlatButton(
              //TODO: get the change picture functionality working
                onPressed: () {
                 setImage();
                },
                child: Text(
                  "Change Photo",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)
    )
  ),
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
              //Updates the user's profile changes to Firestore and User class
                onPressed: () async{
                  if(_image!=null){
                    await uploadImage();
                  }

                  currentUser.updateData(bio:bio,displayName: displayName, photoUrl: url);
                  print("current user url is:"+ currentUser.getPhotoUrl());
                  print(bio);
                  print(displayName);
                  //either sets the image and sends to databse here or in earlier method


                },
                child: Text("Save Changes")),
            RaisedButton(

               onPressed: () {
                 Navigator.pop(context);
               },
                child: Text("Back")),


          ])

  );}

  Future<void> uploadImage() async{
    StorageReference firebaseStorageRef=
    FirebaseStorage.instance.ref().child('profilepic.jpg');
    StorageUploadTask task= firebaseStorageRef.putFile(_image);

    var downloadUrl=await (await task.onComplete).ref.getDownloadURL();
    url=downloadUrl.toString();
    print(url);


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
