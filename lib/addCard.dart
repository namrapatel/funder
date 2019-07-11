import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'classes/user.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'editProfilePage.dart';
import 'loginpage.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'payment.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';


import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class addCard extends StatefulWidget {
  @override
  _addCardState createState() => _addCardState();

}

class _addCardState extends State<addCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController = TextEditingController();
  final TextEditingController _cvvCodeController = MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();

  bool isCvvFocused = false;
  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  void textFieldFocusDidChange() {
    setState(() {
      isCvvFocused = cvvFocusNode.hasFocus;
    });
  }

  @override
  void initState() {
    super.initState();

    cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              IconButton(
              icon: Icon(Icons.close),
              color: Colors.black,
              onPressed: (){
                Navigator.pop(context);
              },
            ),

            CreditCardWidget(
              height: 210,
              cardbgColor: Colors.grey[900],
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                        child: TextFormField(
                          controller: _cardHolderNameController,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Card Holder',
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
                        child:                         TextFormField(
                          controller: _cardNumberController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Card number',
                            hintText: 'xxxx xxxx xxxx xxxx',
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                        child: TextFormField(
                          controller: _expiryDateController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Expired Date',
                              hintText: 'MM/YY'),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
                        child: TextField(
                          focusNode: cvvFocusNode,
                          controller: _cvvCodeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'CVV',
                            hintText: 'XXXX',
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          onChanged: (text) {
                            setState(() {
                              cvvCode = text;
                            });
                          },
                        ),
                      ),
                    SizedBox(
                      height: screenH(20),
                    ),
                SizedBox(
                width: screenW(380),
                height: screenH(65),
                child: new RaisedButton(
                    child: Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 15),),
                    color: Colors.black,
                    onPressed: (){},
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0))
                ),
              ),
              Container(
                height: 30,
              )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
}

































