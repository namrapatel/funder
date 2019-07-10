import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
                0, (MediaQuery.of(context).size.height / 15), 0, 0),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                    (MediaQuery.of(context).size.height / 45), 0, 0, 0),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Activity",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ),
            ],
          ),
          Expanded(
            child: _myListView(context),
          )
        ],
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      itemCount: 15,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/dhruvpatel.jpeg'),
          ),
          title: Text('Notification $index'),
          subtitle: Text("August 9th, 2019",
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
}
