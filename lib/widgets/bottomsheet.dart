import 'package:flutter/material.dart';

void settingModalBottomSheet(context) {
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