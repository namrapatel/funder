import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


final bodyTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: "Varela",
  fontSize: ScreenUtil(allowFontScaling: true).setSp(14.0),
);
final titleTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Varela",
    fontSize: ScreenUtil(allowFontScaling: true).setSp(20.0),
    fontWeight: FontWeight.bold);

Widget buildColorCard(
    BuildContext context, String text, IconData icon, Color color) {
  final _media = MediaQuery.of(context).size;
  return Column(children: <Widget>[
    Container(
      margin: EdgeInsets.only(
          top: ScreenUtil.instance.setHeight(20),
          right: ScreenUtil.instance.setWidth(15)),
      padding: EdgeInsets.all(ScreenUtil.instance.setWidth(12)),
      height: ScreenUtil.instance.setHeight(100),
      width: _media.width / 2 - 25,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[800].withOpacity(0.5),
                blurRadius: 16,
                spreadRadius: 0.2,
                offset: Offset(0, 8)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   text,
          //   style: TextStyle(
          //     fontSize: 18,
          //     color: Colors.white,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Icon(
                      icon,
                      size: ScreenUtil.instance.setHeight(40),
                      color: Colors.black),
                ),
                SizedBox(height: ScreenUtil.instance.setHeight(6.4)),
                Text(
                  text,
                  style: bodyTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    )
  ]);
}
