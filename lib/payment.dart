import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class PaymentsPage extends StatefulWidget {
  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
              Container(
              height: 650.0,
              width: double.infinity,
            ),
              Container(
              height: 250.0,
              width: double.infinity,
              color: Colors.blueAccent[700],
            ),
            Positioned(
              top: 32,
              left: 5,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              ),
            ),
              Positioned(
              top: 125.0,
              left: 15.0,
              right: 15.0,
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(7.0),
                child: Container(
                  height: 250.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 190,
              left: 90,
              child: Text("CAD \$500.00 ", style: TextStyle(fontSize: 35),),
            ),
              Positioned(
              top: 50,
              left: 110,
              child: Text("Payment Methods", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
            ),


            Positioned(
              top: 250,
              left: 60,
              child: new SizedBox(
              width: 300,
              height: 50,
              child: new RaisedButton(
                child: Text("Add Funds", style: TextStyle(color: Colors.white, fontSize: 20),),
                color: Colors.blueAccent[700],
                onPressed: (){},
              ),
            )
            ),
              Positioned(
              top: 150,
              left: 50,
              child: Text("Dime Cash", style: TextStyle(fontSize: 15),),
            ),
              Positioned(
              top: 400,
              left: 30,
              child: Text("Payment Methods", style: TextStyle(fontSize: 15),),
            ),
              Positioned(
              top: 550,
              left: 30,
              child: Text("Promotions", style: TextStyle(fontSize: 15),),
            ),
              Positioned(
              top: 310,
              left: 10,
              child: new SizedBox(
              width: 300,
              height: 50,
              child: Icon(Icons.redeem)
            )
            ),
              Positioned(
              top: 325,
              left: 180,
              child: new SizedBox(
              width: 300,
              height: 50,
              child: Text("Redeem", style: TextStyle(fontSize: 20),)
            )
            ), 
            Positioned(
              top: 425,
              left: 0,
              child:Container(
                color: Colors.white,
                    width: 412,
                    child: ListTile(
                      onTap: (){},
                      title: Text("TD PERSONAL **** 1234",),
                      leading: Icon(Icons.credit_card, color: Colors.grey[700], ),
                      trailing: Icon(SimpleLineIcons.trash, color: Colors.grey[700],),
                      )
                  ),
                  
            ),
              Positioned(
              top: 480,
              left: 0,
              child:Container(
                color: Colors.white,
                    width: 412,
                    child: ListTile(
                      onTap: (){},
                      title: Text("Add Payment Method", style: TextStyle(color: Colors.blueAccent[700]),),
                      
                      )
                  ),
                  
            ),
              Positioned(
              top: 575,
              left: 0,
              child:Container(
                color: Colors.white,
                    width: 412,
                    child: ListTile(
                      onTap: (){
                        _showBottom();
                      },
                      title: Text("Add Promo Code", style: TextStyle(color: Colors.blueAccent[700]),),
                      
                      )
                  ),
                  
            )

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
