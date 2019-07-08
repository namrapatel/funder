import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Dime/homepage.dart';

import 'package:Dime/screens/individualTransaction.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Dime/loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:contacts_service/contacts_service.dart';
bool permissionGranted=true;


class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {

  TextEditingController editingController = TextEditingController();


 getContactsPermission() async{
   Iterable<Contact> contacts2 = await ContactsService.getContacts(withThumbnails: false);
   print(contacts2);
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);

    if(permission== PermissionStatus.denied||permission== PermissionStatus.disabled||permission== PermissionStatus.restricted){
      Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);

      if(permissions[PermissionGroup.contacts]==PermissionStatus.denied){
        print('user denied it');
        permissionGranted=false;

      }else if(permissions[PermissionGroup.contacts]==PermissionStatus.granted){
        print('user accepts');
        permissionGranted=true;
      }

    }



  }



  @override
  void initState() {

    super.initState();

    getContactsPermission();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: screenH(25),
        ),
        title: Text("Select Contacts"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IndividualTransaction(),
                  ));
            },
            icon: Icon(Icons.done),
            iconSize: screenH(25),
          )
        ],
      ),

      body: buildPage()

    );
  }
}


Widget buildPage() {
  TextEditingController editingController = TextEditingController();
  return Container(
    child: Column(
      children: <Widget>[
        Ink(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) {},
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search or Add Friends",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.0)))),
            ),
          ),
        ),
        Expanded(
          child: buildContacts()
        ),

      ],
    ),
  );

}




Widget buildContacts() {
  return FutureBuilder<List<ContactTile>>(
      future: getContacts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator());

        return ListView(
          children: snapshot.data,
          padding: EdgeInsets.only(
            bottom: screenH(15.0),
          ),
          scrollDirection: Axis.vertical,

        );
      });
}


 Future<List<ContactTile>> getContacts() async{
   var accessToken = await fbLogin.currentAccessToken;
   List<ContactTile> contactsTiles=[];
   final token=accessToken.token;
   final graphResponse = await http.get('https://graph.facebook.com/v3.3/me?fields=friends&access_token=${token}');
   final profile = JSON.jsonDecode(graphResponse.body);
     Map userProfile = profile;
    List<String> fbFriendsIds=[];
    for(var key in userProfile["friends"]['data']){
    String fbId= key['id'];
    fbFriendsIds.add(fbId);
    }
   for (var id in fbFriendsIds){
     QuerySnapshot docSnap = await Firestore.instance.collection('users').where('facebookUid',isEqualTo: id).getDocuments();
     List<DocumentSnapshot> docs =docSnap.documents;
     List<String> fbContacts=[];
     for(var doc in docs){
       String name = doc.data['displayName'];
       String photo= doc.data['photoUrl'];
       String uid = doc.documentID;
       fbContacts.add(uid);
       contactsTiles.add(ContactTile(name, photo,uid));
     }

     Firestore.instance.collection('users').document(currentUserModel.uid).updateData({"contacts":FieldValue.arrayUnion(fbContacts)});

   }
   if(permissionGranted==true) {
     Iterable<Contact> contacts = await ContactsService.getContacts();
     for (var contact in contacts) {
       var phone = contact.phones.toList();
       print(phone[0].value);
       String number = phone[0].value;
       QuerySnapshot querySnap = await Firestore.instance.collection('users')
           .where('phoneNumber', isEqualTo: number)
           .getDocuments();

       List<DocumentSnapshot> docs = querySnap.documents;
       List<String> contacts = [];

       for (var doc in docs) {
         String name = doc.data['displayName'];
         String photo = doc.data['photoUrl'];
         String uid = doc.documentID;
         contacts.add(uid);
         contactsTiles.add(ContactTile(name, photo, uid, phoneNumber: number));
       }
       Firestore.instance.collection('users')
           .document(currentUserModel.uid)
           .updateData({"contacts": FieldValue.arrayUnion(contacts)});
     }
   }
   return contactsTiles;

 }



class ContactTile extends StatefulWidget {
  ContactTile(this.contactName, this.personImage,this.uid, {this.phoneNumber});
  final String contactName, personImage, phoneNumber, uid;
  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  bool value1 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        height: screenH(81),
        width: screenW(372),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.personImage),
              ),
              trailing: Checkbox(
                  activeColor: Colors.blueAccent[700],
                  value: value1,
                  checkColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      value1 = value;
                    });
                  }),
              title: Text(widget.contactName),
              subtitle: Text(
                widget.phoneNumber!=null
                ? widget.phoneNumber
                :'',
                style: TextStyle(fontSize: screenF(12)),
              ),
            ),
            Divider(
              color: Colors.grey[400],
              height: screenH(1),
            )
          ],
        ));
  }
}
