import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10, 45, 0, 0),
        ),
        Row(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          ),
        Align(
          alignment: Alignment.topLeft,
          child: Text("Activity", style: TextStyle(fontSize: 30, color: Colors.blueAccent[700]),),
        ),
        Padding(padding: EdgeInsets.fromLTRB(225, 0, 0, 0),),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.search,
            color: Colors.blueAccent[700],
            ),
            onPressed: (){
            },
          )
        )
        ],),
        Expanded(
          child: _myListView(context),
        )
       
      ],
    );
  }
    Widget _myListView(BuildContext context) {
      return ListView.separated(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(SimpleLineIcons.bell, ),
            title: Text('Notification $index'),
            trailing: Icon(Icons.arrow_forward_ios, ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[500],
          );
        },
      );
    }
}