import 'package:flutter/material.dart';
import 'package:funder/screens/groupTransaction.dart';
import 'package:funder/screens/individualTransaction.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Contacts"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupTransaction(),
                  ));
            },
            icon: Icon(Icons.navigate_next),
            iconSize: 40,
          )
        ],
      ),
    );
  }
}

// List<ContactList> contactNames = ["Namra Patel", 5877039807];

class ContactList extends StatefulWidget {
  final String contactName;
  final int phoneNumber;
  ContactList(this.contactName, this.phoneNumber);
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
