import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:funder/screens/Transactions/PaymentTypeSection.dart';
import 'package:funder/screens/Transactions/groupMembers.dart';
import 'package:funder/screens/individualTransaction.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Create a Group"),
        ),
        body: Container(
            child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                PaymentTypeSection(),
                GroupMembersSection(),
                GroupTransactionScreen()
              ],
            ),
          ],
        )));
  }
}

class GroupTransactionScreen extends StatefulWidget {
  @override
  _GroupTransactionScreenState createState() => _GroupTransactionScreenState();
}

class _GroupTransactionScreenState extends State<GroupTransactionScreen> {
  final myController = TextEditingController();
  var charge;
  var splitCharge;
  var numberOfMembers = requestFrom.length;
  int individualValue;
  static bool _value1 = false;

  void _onChanged1(bool value) => setState(() {
        _value1 = value;
      });

  int diningCounter = 0;
  int leisureCounter = 0;
  int rentCounter = 0;
  int groceriesCounter = 0;
  int transportCounter = 0;
  int travelCounter = 0;

  int monthlyCounter = 0;
  int yearlyCounter = 0;

  int recurringON = 0;

  bool leisureIsSelected = false;
  bool rentIsSelected = false;
  bool groceriesIsSelected = false;
  bool transportIsSelected = false;
  bool travelIsSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Text(
                'How much?',
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
                  data: new ThemeData(
                      primaryColor: Colors.black,
                      accentColor: Colors.black,
                      hintColor: Colors.black),
                  child: TextField(
                    controller: myController,
                    onChanged: (text) {
                      if (splitIsSelected == true) {
                        charge = int.parse(text);
                        splitCharge = charge / numberOfMembers;
                        // use splitCharge as the amount that each person owes
                        // (it will be the same for everyone in this case)
                        print(splitCharge);
                      } else {
                        
                        print("Custom Values selected!");
                      }
                    },
                    decoration: InputDecoration(
                        prefixText: "\$ ",
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
            height: 35,
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              Text(
                "What's it for?",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              height: 70.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 45,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              diningCounter++;
                            });
                          },
                          color: Colors.purple,
                          icon: Icon(Icons.local_dining),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: diningCounter % 2 == 0
                              ? Colors.purple.withOpacity(0.03)
                              : Colors.purple.withOpacity(0.20),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Dining',
                        style: TextStyle(color: Colors.purple, fontSize: 12.0),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 45,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              leisureCounter++;
                            });
                          },
                          color: Colors.blue,
                          icon: Icon(Icons.movie),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: leisureCounter % 2 == 0
                              ? Colors.blue.withOpacity(0.03)
                              : Colors.blue.withOpacity(0.2),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Leisure',
                        style: TextStyle(color: Colors.blue, fontSize: 12.0),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 45,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              rentCounter++;
                            });
                          },
                          color: Colors.red,
                          icon: Icon(Icons.home),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: rentCounter % 2 == 0
                              ? Colors.red.withOpacity(0.03)
                              : Colors.red.withOpacity(0.2),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Rent',
                        style: TextStyle(color: Colors.red, fontSize: 12.0),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 45,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              groceriesCounter++;
                            });
                          },
                          color: Colors.teal,
                          icon: Icon(Icons.shopping_cart),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: groceriesCounter % 2 == 0
                              ? Colors.teal.withOpacity(0.03)
                              : Colors.teal.withOpacity(0.2),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Groceries',
                        style: TextStyle(color: Colors.teal, fontSize: 12.0),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 45,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              transportCounter++;
                            });
                          },
                          color: Colors.orange,
                          icon: Icon(Icons.directions_car),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: transportCounter % 2 == 0
                              ? Colors.orange.withOpacity(0.03)
                              : Colors.orange.withOpacity(0.2),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Transport',
                        style: TextStyle(color: Colors.orange, fontSize: 12.0),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 45,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              travelCounter++;
                            });
                          },
                          color: Colors.red,
                          icon: Icon(Icons.flight_takeoff),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: travelCounter % 2 == 0
                              ? Colors.red.withOpacity(0.03)
                              : Colors.red.withOpacity(0.2),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Travel',
                        style: TextStyle(color: Colors.red, fontSize: 12.0),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                ],
              )),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 20.0,
              ),
              Text(
                'Recurring:',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Spacer(),
              CupertinoSwitch(
                value: _value1,
                onChanged: _onChanged1,
                activeColor: Colors.black,
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          _value1 == true ? BuildRecurring() : Container(),
          SizedBox(
            height: 30.0,
          ),
          Container(
            height: 40,
            width: 330,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 16,
                    spreadRadius: 0.2,
                    offset: Offset(0, 8)),
              ],
            ),
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {},
              color: Colors.black,
              textColor: Colors.white,
              child: Text('Send'),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> monthlyDates = [
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31'
];

List<String> daysOfTheWeek = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday'
      'Sunday'
];

int selected_item = 0;

class BuildWeeklyItemPicker extends StatefulWidget {
  @override
  _BuildWeeklyItemPickerState createState() => _BuildWeeklyItemPickerState();
}

class _BuildWeeklyItemPickerState extends State<BuildWeeklyItemPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: CupertinoPicker(
        itemExtent: 7.0,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: (index1) {
          setState(() {
            selectedWItemString2 = daysOfTheWeek[index1];
          });
        },
        children: List<Widget>.generate(
          daysOfTheWeek.length,
          (index1) {
            return Center(
              child: Text(daysOfTheWeek[index1]),
            );
          },
        ),
      ),
    );
  }
}

class BuildMonthlyItemPicker extends StatefulWidget {
  @override
  _BuildMonthlyItemPickerState createState() => _BuildMonthlyItemPickerState();
}

class _BuildMonthlyItemPickerState extends State<BuildMonthlyItemPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: CupertinoPicker(
        itemExtent: 31.0,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: (index2) {
          setState(() {
            selected_item = index2;
            selectedItemString2 = selected_item.toString();
          });
        },
        children: List<Widget>.generate(
          monthlyDates.length,
          (index2) {
            return Center(
              child: Text(monthlyDates[index2]),
            );
          },
        ),
      ),
    );
  }
}

class BuildWeekly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Text('Every'),
        SizedBox(
          width: 7.0,
        ),
        InkWell(
          child: Text(
              selectedWItemString2 == null ? "_______" : selectedWItemString2),
          onTap: () async {
            await showModalBottomSheet<int>(
              context: context,
              builder: (BuildContext context) {
                BuildWeeklyItemPicker();
                // return _buildWeeklyItemPicker();
              },
            );
          },
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child:
                Text("⌄", style: TextStyle(color: Colors.black, fontSize: 30)),
          ),
          onTap: () async {
            await showModalBottomSheet<int>(
              context: context,
              builder: (BuildContext context) {
                BuildWeeklyItemPicker();
              },
            );
          },
        ),
      ],
    ));
  }
}

class BuildMonthly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Text('Every'),
        SizedBox(
          width: 10.0,
        ),
        InkWell(
          child: Text(selected_item == 0 ? "_____" : selectedItemString2),
          onTap: () async {
            await showModalBottomSheet<int>(
              context: context,
              builder: (BuildContext context) {
                return BuildMonthlyItemPicker();
              },
            );
          },
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 14.0),
            child:
                Text("⌄", style: TextStyle(color: Colors.black, fontSize: 30)),
          ),
          onTap: () async {
            await showModalBottomSheet<int>(
              context: context,
              builder: (BuildContext context) {
                return BuildMonthlyItemPicker();
              },
            );
          },
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          'of the month.',
        ),
      ],
    ));
  }
}

class BuildRecurring extends StatefulWidget {
  @override
  _BuildRecurringState createState() => _BuildRecurringState();
}

class _BuildRecurringState extends State<BuildRecurring> {
  bool weeklyIsSelected = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 40,
              ),
              Text(
                'Cycle:',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(
                width: 25.0,
              ),
              Container(
                height: 30,
                width: 70,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      weeklyIsSelected = true;
                    });
                  },
                  child: Center(
                    child: Text(
                      'Weekly',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: weeklyIsSelected == false
                      ? Colors.black.withOpacity(0.03)
                      : Colors.black.withOpacity(0.15),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Container(
                height: 30,
                width: 70,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      weeklyIsSelected = false;
                    });
                  },
                  child: Center(
                    child: Text(
                      'Monthly',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: weeklyIsSelected == true
                      ? Colors.black.withOpacity(0.03)
                      : Colors.black.withOpacity(0.15),
                ),
              ),
              SizedBox(
                width: 25,
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 40,
              ),
              Text(
                'Date:',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(
                width: 35.0,
              ),
              weeklyIsSelected == true ? BuildWeekly() : BuildMonthly()
            ],
          ),
        ],
      ),
    );
  }
}
