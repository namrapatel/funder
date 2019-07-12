import 'package:flutter/material.dart';

 bool splitIsSelected = true;
class PaymentTypeSection extends StatefulWidget {
  @override
  _PaymentTypeSectionState createState() => _PaymentTypeSectionState();
}

class _PaymentTypeSectionState extends State<PaymentTypeSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Text(
              'Name',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Theme(
                // data: theme.copyWith(primaryColor: Colors.black),
                data: new ThemeData(
                    primaryColor: Colors.black,
                    accentColor: Colors.black,
                    hintColor: Colors.black),
                child: TextField(
                  decoration: InputDecoration(
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black))),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  cursorColor: Colors.black,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Text(
              'What type of payment?',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Container(
              height: 30,
              width: 140,
              child: InkWell(
                onTap: () {
                  setState(() {
                    splitIsSelected = true;
                  });
                },
                child: Center(
                  child: Text(
                    'Split the Total',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: splitIsSelected == false
                    ? Colors.black.withOpacity(0.03)
                    : Colors.black.withOpacity(0.15),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Container(
              height: 30,
              width: 140,
              child: InkWell(
                onTap: () {
                  setState(() {
                    splitIsSelected = false;
                  });
                },
                child: Center(
                  child: Text(
                    'Custom Values',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: splitIsSelected == true
                    ? Colors.black.withOpacity(0.03)
                    : Colors.black.withOpacity(0.15),
              ),
            ),
          ],
        )
      ],
    );
  }
}