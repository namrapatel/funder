import 'package:flutter/material.dart';
import 'package:Dime/homepage.dart';
import 'individualTransaction.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
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
        child: ListView(
          padding: EdgeInsets.only(
            bottom: screenH(15.0),
          ),
          scrollDirection: Axis.vertical,
          children: contacts,
        ),
      ),
    );
  }
}

List<ContactTile> contacts = [
  ContactTile("Namra Patel", "assets/namrapatel.png", "(587)-703-9807"),
  ContactTile("Taher Anky", "assets/taher.jpeg", "(587)-703-9807"),
  ContactTile("Shehab Salem", "assets/shehabsalem.jpeg", "(587)-703-9807"),
  ContactTile("Sean Mei", "assets/seanmei.jpeg", "(587)-703-9807"),
];

class ContactTile extends StatefulWidget {
  ContactTile(this.contactName, this.personImage, this.phoneNumber);
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
                backgroundImage: AssetImage(widget.personImage),
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
                widget.phoneNumber,
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
