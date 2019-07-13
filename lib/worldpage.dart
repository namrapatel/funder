import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Dime/homepage.dart';
import 'package:Dime/screens/individualTransaction.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Dime/loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:contacts_service/contacts_service.dart';

class WorldPage extends StatefulWidget {
  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;


  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
          height: screenH(340.0),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, screenH(25), 0, 0),),
              Text("Invite your Friends", style: TextStyle(fontSize: 20, color: Colors.black), ),
              Padding(
                padding: EdgeInsets.all(screenH(20)),
                child: Text("Dime is better with friends! Invite your friends and earn bonus cash back.", style: TextStyle(fontSize: 15, color: Colors.grey), textAlign: TextAlign.center, ),
              ),
              // Spacer(),
              Row(
                children: <Widget>[
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: Color(0xFF0078FF),
                    elevation: 7,
                    child: Icon(MaterialCommunityIcons.facebook_messenger, size: 28,),
                    onPressed: (){
                    },
                  ),
                  Spacer(),
                    FloatingActionButton(
                    backgroundColor: Color(0xFF25d366),
                    elevation: 7,
                    child: Icon(MaterialCommunityIcons.whatsapp, color: Colors.white, size: 28,),
                    onPressed: (){},
                  ),
                  Spacer(),
                    FloatingActionButton(
                    backgroundColor: Color(0xFFDB4437),
                    elevation: 7,
                    child: Icon(MaterialCommunityIcons.email_open_outline, color: Colors.white, size: 28),
                    onPressed: (){},
                  ),
                  Spacer(),
                    FloatingActionButton(
                    backgroundColor: Colors.grey[50],
                    elevation: 5,
                    child: Icon(Ionicons.ios_text, color: Colors.blueAccent[700], size: 28),
                    onPressed: (){},
                  ),

                  Spacer(),


                ],
              ),
              Spacer(),

              Padding(padding: EdgeInsets.fromLTRB(screenW(15), 0, screenW(15), screenW(15)),
              child: TextField(
              onChanged: (value) {},
              //controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search or Add Friends",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)))),
            ),
              ),
              // Spacer(),
            ],
          ),
          ),
      DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(tabs: [Tab(icon: Icon(AntDesign.contacts,),), Tab(icon: Icon(Zocial.facebook, size: 22,),)],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              
              ),

              Container(
                  height: screenH(900), 
                  child: TabBarView(
                    children: [
                      _myListView(context),
                      buildContacts()
                      ],
                  ))
            ],
          ))
    ]);
  }

  Widget _myListView(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      itemCount: 8,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/dhruvpatel.jpeg'),
          ),
          title: Text('Person $index'),
          trailing: SizedBox(
          width: screenW(35),
          height: screenW(35),
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.black,
            child: Icon(Icons.done, size: 15,),
            onPressed: () {},
          ),
        ),
          subtitle: Text("(123) 456-7890",
              style: TextStyle(
                fontSize: screenF(13),
              )),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey[500],
        );
      },
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
  var accessToken = await fbLogin.currentAccessToken;
  List<ContactTile> contactsTiles = [];
  final token = accessToken.token;
  final graphResponse = await http.get(
      'https://graph.facebook.com/v3.3/me?fields=friends&access_token=${token}');
  final profile = JSON.jsonDecode(graphResponse.body);
  Map userProfile = profile;
  List<String> fbFriendsIds = [];
  for (var key in userProfile["friends"]['data']) {
    String fbId = key['id'];
    fbFriendsIds.add(fbId);
  }
  for (var id in fbFriendsIds) {
    QuerySnapshot docSnap = await Firestore.instance
        .collection('users')
        .where('facebookUid', isEqualTo: id)
        .getDocuments();
    List<DocumentSnapshot> docs = docSnap.documents;
    List<String> fbContacts = [];
    for (var doc in docs) {
      String name = doc.data['displayName'];
      String photo = doc.data['photoUrl'];
      String uid = doc.documentID;
      fbContacts.add(uid);
      contactsTiles.add(ContactTile(name, photo, uid));
    }

    Firestore.instance
        .collection('users')
        .document(currentUserModel.uid)
        .updateData({"contacts": FieldValue.arrayUnion(fbContacts)});
  }
  if (permissionGranted == true) {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    for (var contact in contacts) {
      var phone = contact.phones.toList();
      print(phone[0].value);
      String number = phone[0].value;
      QuerySnapshot querySnap = await Firestore.instance
          .collection('users')
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
      Firestore.instance
          .collection('users')
          .document(currentUserModel.uid)
          .updateData({"contacts": FieldValue.arrayUnion(contacts)});
    }
  }
  return contactsTiles;
}

}

class ContactTile extends StatefulWidget {
  ContactTile(this.contactName, this.personImage, this.uid, {this.phoneNumber});
  final String contactName, personImage, phoneNumber, uid;
  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {

    final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  bool value1 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        height: screenH(97),
        width: screenW(372),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.personImage),
              ),
          trailing: SizedBox(
          width: screenW(35),
          height: screenW(35),
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.black,
            child: Icon(Icons.add, size: 15,),
            onPressed: () {},
          ),
        ),
              title: Text(widget.contactName),
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