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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenH(100)), 
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text("Activity", style: TextStyle(fontSize: 30),),
          elevation: 0,
        ),
      ),

      body: Column(
        children: <Widget>[
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
