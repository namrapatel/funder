import 'package:flutter/material.dart';
import 'utils/screen_size.dart';
import 'ui/tab_1_view.dart';
import 'ui/tab_2_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20,
          top: 70,
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Overview",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                iconSize: 25.0,
                color: Colors.amber[800],
                icon: Icon(Icons.create),
                onPressed: () {
                  _settingModalBottomSheet(context);
                },
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildColorCard(
                  context, "You are Owed", 35.17, 1, Color(0xFF00E676)),
              _buildColorCard(context, "You Owe", 4978, -1, Color(0xFFff3f5e))
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// Function for bottom sheet.
void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 10.0),
                  leading: new Icon(Icons.call_split),
                  title: new Text('Split a Payment'),
                  subtitle: new Text(
                      'Request to split a payment between a group of people.'),
                  onTap: () => {}),
              new Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              new ListTile(
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 0.0, 20.0),
                  leading: new Icon(Icons.send),
                  title: new Text('Send to Contact'),
                  subtitle: new Text(
                      'Send money to individuals on your friends list.'),
                  onTap: () => {}),
            ],
          ),
        );
      });
}

Widget _buildTabBarController(BuildContext context) {}

Widget _buildColorCard(
    BuildContext context, String text, double amount, int type, Color color) {
  final _media = MediaQuery.of(context).size;
  return Column(children: <Widget>[
    Container(
      margin: EdgeInsets.only(top: 50, right: 15),
      padding: EdgeInsets.all(15),
      height: screenAwareSize(90, context),
      width: _media.width / 2 - 25,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 16,
                spreadRadius: 0.2,
                offset: Offset(0, 8)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "${type > 0 ? "" : "-"} \$ ${amount.toString()}",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    )
  ]);
}
