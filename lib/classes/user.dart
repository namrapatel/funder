       import 'package:cloud_firestore/cloud_firestore.dart';
       import 'package:firebase_auth/firebase_auth.dart';
       import 'package:image_picker/image_picker.dart';
       import 'dart:io';

       class User {
       final _firestore = Firestore.instance;
         final _auth = FirebaseAuth.instance;
         FirebaseUser loggedInUser;

         String displayName;
         String email;
         String bio;
         File _image;
         String photoUrl;
         String uid;

        Future<void> setImage() async {
             _image = await ImagePicker.pickImage(source: ImageSource.gallery);


          }





         //Gets the current logged in user and the email they logged in with

         Future<void> getCurrentUser() async{
             try{
               final user= await _auth.currentUser();

               if(user!=null){
                 loggedInUser=user;
                 email=loggedInUser.email;
                 uid= loggedInUser.uid;
               }}
             catch(e){
               print(e);
             }
           }

            //Retrieves specific data values from the user's document from firebase
            //May need to clean some of this up and make it more efficient, remove the 'then'

           Future<void> getInfo() async {
               await getCurrentUser();

               DocumentReference documentReference =
               _firestore.collection("users").document("$uid");
               await documentReference.get().then((DocumentSnapshot datasnapshot) {
                 if (datasnapshot.exists) {
                   displayName=datasnapshot.data['display name'].toString();
                   bio=datasnapshot.data['bio'].toString();
                   email=datasnapshot.data['email'].toString();
                   photoUrl= datasnapshot.data['photoUrl'].toString();
                 }
                 else {
                   print("No such user");
                 }

               });

             }

           //User constructor with optional parameters, checks whether values are valid too

          User({String bio,String displayName, File image}){
          if(bio!=null){
           this.bio= bio;
           print(this.bio);
          }
          if(displayName!=null){
          this.displayName = displayName;
         }
          if(image!=null){
                  this._image= image;
                  }

          }

           //Updates the data changed on both the firestore and the instance variables

          void updateData({String email, String bio, String displayName, String photoUrl}){

          if(bio!=null){
           this.bio=bio;
           print(this.bio);
           }
           if(displayName!=null){
           this.displayName=displayName;
           }
           if(photoUrl!=null){
           this.photoUrl= photoUrl;
           }
          _firestore.collection('users').document('$uid').setData({
          'email':this.email,
          'bio':this.bio,
          'display name':this.displayName,
          'photoUrl':this.photoUrl

          });

       }

        //Getters for the instance variables

           String getBio(){
           return bio;
           }

           String getDisplayName(){
           return displayName;
           }

           String getEmail(){
           return email;
           }

           String getPhotoUrl(){
           return photoUrl;
           }

       }