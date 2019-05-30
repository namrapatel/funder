import 'package:flutter/material.dart';
import 'package:funder/utils/screen_size.dart';

Widget buildColorCard(
    BuildContext context, String text, double amount, int type, Color color) {
  final _media = MediaQuery.of(context).size;
  return Column(children: <Widget>[
    Container(
      margin: EdgeInsets.only(top: 50, right: 15),
      padding: EdgeInsets.all(15),
      height: screenAwareSize(72.5, context),
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
