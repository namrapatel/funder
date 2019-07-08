import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentsPage extends StatefulWidget {
  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {

  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: screenH(850),
              width: double.infinity,
            ),
            Container(
              height: screenH(350),
              width: double.infinity,
              color: Colors.blueAccent[700],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height / 16),
              left: (MediaQuery.of(context).size.width / 45),
              //top: 32,
              //left: 5,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              ),
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 5.7),
              left: (MediaQuery.of(context).size.width / 21),
              right: (MediaQuery.of(context).size.width / 21),
              // top: 125.0,
              // left: 15.0,
              // right: 15.0,
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(7.0),
                child: Container(
                  height: screenH(330),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.white),
                ),
              ),
            ),
            Positioned(
              //top: 190,
              top: (MediaQuery.of(context).size.height / 3.7),
              //left: 90,
              left: (MediaQuery.of(context).size.width / 4),
              child: Text("CAD \$500.00 ", style: TextStyle(fontSize: 35),),
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 9),
              left: (MediaQuery.of(context).size.width / 3.8),
              child: Text("Payment Methods", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
            ),


            Positioned(
              top: (MediaQuery.of(context).size.height / 2.8),
              left: (MediaQuery.of(context).size.width / 7),
              child: new SizedBox(
              width: screenW(300),
              height: screenH(75),
              child: new RaisedButton(
                child: Text("Add Funds", style: TextStyle(color: Colors.white, fontSize: 20),),
                color: Colors.blueAccent[700],
                onPressed: (){},
              ),
            )
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 4.8),
              left: (MediaQuery.of(context).size.width / 8),
              child: Text("Dime Cash", style: TextStyle(fontSize: 15),),
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 1.72),
              //left: 30,
              left: (MediaQuery.of(context).size.width / 14),
              child: Text("Payment Methods", style: TextStyle(fontSize: 15),),
            ),

              Positioned(
              top: (MediaQuery.of(context).size.height / 2.2),
              left: (MediaQuery.of(context).size.width / 29),
              child: new SizedBox(
              width: screenW(300),
              height: screenH(65),
              child: Icon(Icons.redeem)
            )
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 2.1),
              left: (MediaQuery.of(context).size.width / 2.25),
              child: new SizedBox(
              width: screenW(300),
              height: screenH(65),
              child: Text("Redeem", style: TextStyle(fontSize: 20),)
            )
            ), 
            Positioned(
              top: (MediaQuery.of(context).size.height / 1.61),
              //top: 425,
              left: 0,
              child:Container(
                color: Colors.white,
                    width: screenW(415),
                    child: ListTile(
                      onTap: (){},
                      title: Text("TD PERSONAL **** 1234",),
                      leading: Icon(Icons.credit_card, color: Colors.grey[700], ),
                      trailing: Icon(SimpleLineIcons.trash, color: Colors.grey[700],),
                      )
                  ),
                  
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 1.45),
              left: 0,
              child:Container(
                color: Colors.white,
                    width: screenW(415),
                    child: ListTile(
                      onTap: (){},
                      title: Text("Add Payment Method", style: TextStyle(color: Colors.blueAccent[700]),),
                      
                      )
                  ),
                  
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 1.199),
              left: 0,
              child:Container(
                color: Colors.white,
                    width: screenW(415),
                    child: ListTile(
                      onTap: (){
                        _showBottom();
                      },
                      title: Text("Add Promo Code", style: TextStyle(color: Colors.blueAccent[700]),),
                      
                      )
                  ),
                  
            ),
              Positioned(
              top: (MediaQuery.of(context).size.height / 1.25),
              left: (MediaQuery.of(context).size.width / 14),
              child: Text("Promotions", style: TextStyle(fontSize: 15),),
            ),

        ],
      ),
    );
  }

    void _showBottom(){
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context){
          return new Container(
            padding: new EdgeInsets.all(15.0),
            height: 1000,
            child: new Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Padding(
                     padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(hintText: "Enter your promo code"),
                              autofocus: true,
                            ),
                            SizedBox(height: 15.0),
                            Row(children: <Widget>[
                              SizedBox(
                              width: 150,
                              height: 40,
                              child: new OutlineButton(
                                child: Text("Cancel", style: TextStyle(color: Colors.black, fontSize: 15),),
                                color: Colors.black,
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                           SizedBox(
                          width: 150,
                          height: 40,
                          child: new RaisedButton(
                            child: Text("Add", style: TextStyle(color: Colors.white, fontSize: 15),),
                            color: Colors.blueAccent[700],
                            onPressed: (){},
                          ),
                        )
                            ],)

                          ],
                        ),
                  ),
                ),



                
              ],
            ),
          );
        }
    );
  }

}
