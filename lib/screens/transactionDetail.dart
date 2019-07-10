import 'package:flutter/material.dart';
import 'package:Dime/homepage.dart';

class TransactionDetail extends StatefulWidget {
  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: 896,
          width: 400,
          color: Colors.black,
          child: Column(
            children: <Widget>[
              SizedBox(height: 70),
              Container(
                  height: 550,
                  width: 320,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 5,
                            offset: Offset(0, 5)),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Ivey Business Case Comp",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: Text(
                                            "CREATED BY",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          "Namra Patel",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "(587)-703-9807",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 25.0),
                                      child: CircleAvatar(
                                        backgroundImage:
                                            AssetImage('assets/namrapatel.png'),
                                        radius: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "DATE",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "August 9th, 2019",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 25.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "TIME",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "9:41 PM",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Divider(
                            indent: 20,
                            color: Colors.grey[700],
                            height: 1,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Participants",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        Container(
                            height: 200,
                            width: 280,
                            // decoration: BoxDecoration(
                            //     color: Colors.transparent,
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.black.withOpacity(0.25),
                            //         offset: const Offset(0.0, 0.0),
                            //       ),
                            //       BoxShadow(
                            //         color: Colors.grey[300],
                            //         offset: const Offset(0.0, 0.0),
                            //         spreadRadius: -12.0,
                            //         blurRadius: 12.0,
                            //       ),
                            //     ],
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(15))),
                            child: ListView(
                                padding: EdgeInsets.all(0),
                                children: splitsCard)),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 175.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Total Requested",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("500.00",
                                      style: TextStyle(
                                          color: Colors.redAccent[700])),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Total Paid",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("500.00",
                                      style: TextStyle(
                                          color: Colors.greenAccent[700])),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              IconButton(
                icon: Icon(Icons.cancel),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 60,
              )
            ],
          ),
        )
      ]),
    );
  }
}

List<SplitsCard> splitsCard = [
  SplitsCard(
      personName: "Shehab Salem",
      personPic: "assets/shehabsalem.jpeg",
      phoneNumber: "(587)-703-9807",
      paidValue: "-49.40",
      status: "1"),
  SplitsCard(
      personName: "Dhruv Patel",
      personPic: "assets/dhruvpatel.jpeg",
      phoneNumber: "(587)-703-9807",
      paidValue: "-10.81",
      status: "-1"),
  SplitsCard(
      personName: "Taher Anky",
      personPic: "assets/taher.jpeg",
      phoneNumber: "(587)-703-9807",
      paidValue: "-19.99",
      status: "-1")
];

class SplitsCard extends StatelessWidget {
  final String personName, personPic, phoneNumber, paidValue, status;

  SplitsCard(
      {this.personName,
      this.personPic,
      this.phoneNumber,
      this.paidValue,
      this.status});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
          height: 45,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    status == "1" ? Icons.done : Icons.hourglass_empty,
                    color: status == "1"
                        ? Colors.greenAccent[700]
                        : Colors.redAccent[700],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(this.personPic),
                      radius: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(this.personName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 2,
                        ),
                        Text(this.phoneNumber,
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 8.0),
                        child: Text(
                          this.paidValue,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
