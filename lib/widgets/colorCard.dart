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

Widget colorCard(
    String text, double amount, int type, BuildContext context, Color color) {
  final _media = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(top: 15, right: 15),
    padding: EdgeInsets.all(15),
    height: 90,
    width: _media.width / 2 - 25,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "${type > 0 ? "" : "-"} \$ ${amount.toString()}",
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}