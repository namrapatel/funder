import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Dime/homepage.dart';
import 'package:Dime/screens/individualTransaction.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Dime/loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:contacts_service/contacts_service.dart';
import 'package:Dime/classes/user.dart';
List<ContactTile> allUsers=[];
List<String>selectedUsersUids=[];
List<ContactTile> suggestionList=[];
Set<String> selections;
List allContacts=[];
bool syncedContacts=false;
bool permissionGranted;


class DataSearch extends SearchDelegate<
    String> {

//  final recentSearches=[ContactTile('Dhruv Patel','https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=2250762621659276&height=800&width=800&ext=1565358714&hash=AeTMZgz--e2JNS2J','bK5iO87AyBbyUtkRXOiyGEfVis83',)];


  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        query='';

      },
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: (){
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    suggestionList= query.isEmpty?[]: allUsers.where(
            (contact)=>(contact.phoneNumber==null?

        ((contact.contactName.startsWith(query))):
        ((contact.contactName.startsWith(query))|| ((contact.phoneNumber.startsWith(query)))))).toList();

    return
      ListView.builder(
          shrinkWrap: true,

          itemBuilder: (BuildContext context, int index) {
            return suggestionList[index];
          },itemCount: suggestionList.length);


  }

}


class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(allUsers.length==0) {
      getAllUsers();
    }

//    getContactsPermission();
  }

  getAllUsers() async{
    List<ContactTile> users=[];
    QuerySnapshot userDocs= await Firestore.instance.collection('users').getDocuments();

    for(var doc in userDocs.documents){
      String name = doc.data['displayName'];
      String photo = doc.data['photoUrl'];
      String uid = doc.documentID;
      String phone = doc.data['phoneNumber'];
      users.add(ContactTile(name,photo,uid,phoneNumber: phone));

    }
    setState(() {
      allUsers=users;
    });

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
            syncedContacts==false?
            FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius:
                    new BorderRadius.circular(15.0)),
            color: Colors.white,
            child: Text(
            "Sync",
            style: TextStyle(color: Colors.black),
            ),
            onPressed: () async{
              await syncContacts();
            setState(() {
              buildContacts();
            });



            },


        ):SizedBox(width: 1),
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
            ),
            IconButton(
              onPressed: (){
                showSearch(context: context, delegate:DataSearch() );

              },
              icon: Icon(Icons.search),
              iconSize: screenH(25),
            )
          ],
        ),
        drawer: Drawer(),

        body: buildPage());
  }
}

Widget buildPage() {
  TextEditingController editingController = TextEditingController();
  return Container(
    child: Column(
      children: <Widget>[

        Expanded(child: buildContacts()),
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



Future<List<ContactTile>> getContacts() async {
//  var accessToken = await fbLogin.currentAccessToken;
  List<ContactTile> contactsTiles = [];
//  List<String> fbContacts = [];
//  final token = accessToken.token;
//  final graphResponse = await http.get(
//      'https://graph.facebook.com/v3.3/me?fields=friends&access_token=${token}');
//  final profile = JSON.jsonDecode(graphResponse.body);
//  Map userProfile = profile;
//  List<String> fbFriendsIds = [];
//  for (var key in userProfile["friends"]['data']) {
//    String fbId = key['id'];
//    fbFriendsIds.add(fbId);
//  }
//  for (var id in fbFriendsIds) {
//    QuerySnapshot docSnap = await Firestore.instance
//        .collection('users')
//        .where('facebookUid', isEqualTo: id)
//        .getDocuments();
//    List<DocumentSnapshot> docs = docSnap.documents;
//
//    for (var doc in docs) {
//      String name = doc.data['displayName'];
//      String photo = doc.data['photoUrl'];
//      String uid = doc.documentID;
//      fbContacts.add(uid);
////      contactsTiles.add(ContactTile(name, photo, uid));
//    }
//
//  }
//  addContact(fbContacts);

  DocumentSnapshot documentSnapshot= await Firestore.instance.collection('users').document(currentUserModel.uid).get();
  allContacts =documentSnapshot.data['contacts'];
  print('allcontacts');
  print(allContacts);
  for(var contact in allContacts) {
    DocumentSnapshot docSnap = await Firestore.instance
        .collection('users').document(contact).get();
    String name=docSnap.data['displayName'];
    String photo = docSnap.data['photoUrl'];
    String phone = docSnap.data['phoneNumber'];
            contactsTiles.add(ContactTile(name, photo, contact, phoneNumber: phone));

  }
print(contactsTiles);
  return contactsTiles;
}

syncContacts() async {
  List<String> contacts = [];
  print(permissionGranted);
  if (permissionGranted == true) {
    Iterable<Contact> phoneContacts = await ContactsService.getContacts();
    for (var contact in phoneContacts) {
      var phone = contact.phones.toList();
      print(phone[0].value);
      String number = phone[0].value;
      print(number);
      QuerySnapshot querySnap = await Firestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: number)
          .getDocuments();

      List<DocumentSnapshot> docs = querySnap.documents;
      for (var doc in docs) {
        String uid = doc.documentID;
        contacts.add(uid);
      }
    }
    addContact(contacts);
    syncedContacts=true;



  }else{
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler()
        .requestPermissions([PermissionGroup.contacts]);

    if (permissions[PermissionGroup.contacts] == PermissionStatus.denied) {
      print('user denied it');
      permissionGranted = false;
    } else if (permissions[PermissionGroup.contacts] ==
        PermissionStatus.granted) {
      print('user accepts');
      permissionGranted = true;
      syncContacts();
    }
  }
}

addContact(List contacts){
  Firestore.instance
      .collection('users')
      .document(currentUserModel.uid)
      .updateData({"contacts": FieldValue.arrayUnion(contacts)});

}

class ContactTile extends StatefulWidget{
  ContactTile(this.contactName, this.personImage, this.uid, {this.phoneNumber});
  final String contactName, personImage, phoneNumber, uid;


  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  bool value1 = false;

  @override
  Widget build(BuildContext context) {
    if(selectedUsersUids.contains(widget.uid)){
      setState(() {
        value1=true;
      });
    }else{
      setState(() {
        value1=false;
      });
    }
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        height: screenH(97),
        width: screenW(372),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              onTap: (){

              },
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.personImage),
              ),
              trailing: Container(
                height: screenH(97),
                width: screenW(200),
                child: Row(
                  children: <Widget>[

                    SizedBox(width: 50),
                    !allContacts.contains(widget.uid)?
                    FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius:
                          new BorderRadius.circular(15.0)),
                      color: Colors.black,
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        List ids= [];
                        ids.add(widget.uid);
                        addContact(ids);
                        buildContacts();
                      },
                    ):SizedBox(width: 88),
                    Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: value1,
                        onChanged: (bool value) {
                          setState(() {
                            if(widget.uid==currentUserModel.uid) {
                              value1 = false;
                            }else {
                              value1=value;
                              if (value1 == true) {
                                selectedUsersUids.add(widget.uid);
                              } else {
                                selectedUsersUids.remove(widget.uid);

                              }
                            }
                            selections=selectedUsersUids.toSet();
                            print(selections);
                          });
                        }),

                  ],
                ),
              ),

              title: Text(widget.contactName=="You currently don't have a display name"?'':widget.contactName),
              subtitle: Text(
                widget.phoneNumber != null ? widget.phoneNumber : '',
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