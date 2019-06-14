       import 'package:cloud_firestore/cloud_firestore.dart';
       import 'package:firebase_auth/firebase_auth.dart';

       class User {
       final _firestore = Firestore.instance;
         final _auth = FirebaseAuth.instance;
         FirebaseUser loggedInUser;

         String displayName;
         String email;
         String bio;


         //Gets the current logged in user and the email they logged in with

         Future<void> getCurrentUser() async{
             try{
               final user= await _auth.currentUser();

               if(user!=null){
                 loggedInUser=user;
                 email=loggedInUser.email;
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
               _firestore.collection("users").document("$email");
               await documentReference.get().then((DocumentSnapshot datasnapshot) {
                 if (datasnapshot.exists) {
                   displayName=datasnapshot.data['displayName'].toString();
                   bio=datasnapshot.data['bio'].toString();
                   print(bio);
                 }
                 else {
                   print("No such user");
                 }

               });

             }

           //User constructor with optional parameters, checks whether values are valid too

          User({String bio,String displayName}){
          if(bio!=null){
           this.bio= bio;
           print(this.bio);
          }
          if(displayName!=null){
          this.displayName = displayName;
       }

          }

           //Updates the data changed on both the firestore and the instance variables

          void updateData({String bio, String displayName}){

          if(bio!=null){
           this.bio=bio;
           print(this.bio);
           }
           if(displayName!=null){
           this.displayName=displayName;
           }
          _firestore.collection('users').document('$email').setData({
          'bio':this.bio,
          'displayName':this.displayName
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
       }