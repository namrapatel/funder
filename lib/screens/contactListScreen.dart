import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Dime/homepage.dart';
import 'package:Dime/screens/individualTransaction.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Dime/loginpage.dart';



class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  TextEditingController editingController = TextEditingController();


  getContactsPermission() async{
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
    print(permissions);
  }
  @override
  void initState() {
    super.initState();
    getFbFriendsInfo();
//    getContactsPermission();
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
      body: Container(
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
              child: ListView(
                padding: EdgeInsets.only(
                  bottom: screenH(15.0),
                ),
                scrollDirection: Axis.vertical,
                children: contacts,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 getFbFriendsInfo() async{
   DocumentSnapshot fbUserRecord= await Firestore.instance.collection('users').document(currentUserModel.uid).get();
   List<dynamic> ids=fbUserRecord.data['fbFriends'];
   for (var id in ids){
     QuerySnapshot docSnap = await Firestore.instance.collection('users').where('facebookUid',isEqualTo: id).getDocuments();
     List<DocumentSnapshot> docs =docSnap.documents;
     for(var doc in docs){
       String name = doc.data['displayName'];
       String photo= doc.data['photoUrl'];
       contacts.add(ContactTile(name, photo));
     }

   }

 }
List<ContactTile> contacts = [];

class ContactTile extends StatefulWidget {
  ContactTile(this.contactName, this.personImage, {this.phoneNumber});
  final String contactName, personImage, phoneNumber;
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
//              subtitle: Text(
//                widget.phoneNumber!=null
//                ? widget.phoneNumber
//                :null,
//                style: TextStyle(fontSize: screenF(12)),
//              ),
            ),
            Divider(
              color: Colors.grey[400],
              height: screenH(1),
            )
          ],
        ));
  }
}
