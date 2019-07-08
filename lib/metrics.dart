import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MetricsPage extends StatefulWidget {
  @override
  _MetricsPageState createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  Color primaryColor = Color.fromRGBO(255, 82, 48, 1);

  @override
  Widget build(BuildContext context) {
    var data = [
      ClickPerMonth('Dining', 30, Colors.purple),
      ClickPerMonth('Leisure', 42, Colors.blue),
      ClickPerMonth('Rent', 54, Colors.orange),
      ClickPerMonth('Groceries', 20, Colors.green),
      ClickPerMonth('Transport', 76, Colors.yellow),
      //ClickPerMonth('Jun', 35, Colors.blue),
    ];

    var series = [
      new charts.Series(
          id: 'Clicks',
          outsideLabelStyleAccessorFn: (ClickPerMonth clickData, _) {
          return new charts.TextStyleSpec(color: charts.MaterialPalette.white);
          },
          domainFn: (ClickPerMonth clickData, _) => clickData.month,
          measureFn: (ClickPerMonth clickData, _) => clickData.clicks,
          colorFn: (ClickPerMonth clickData, _) => clickData.color,
          data: data),
    ];

    var chart = new charts.BarChart(series,
        
        animate: true,  animationDuration: Duration(milliseconds: 1000));

    var chartWidget =Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(height: 180.0, child: chart),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(top: 30.0, right: 15.0, left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.black54,
                      //iconSize: 30.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              child: Text('Metrics',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: double.infinity,
                height: 370.0,
                decoration: BoxDecoration(
                    color: Colors.blueAccent[700],
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0.0, 0.3),
                          blurRadius: 15.0)
                    ]),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'CAD \$500.00',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Total transactions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    chartWidget,
                    
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 30.0),
              child: Text(
                'Activity',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 25.0),

            Container(
              height: 450,
              child: _myListView(context),
            )
          ],
        ),
      ),
    );
  }

          Widget _myListView(BuildContext context) {

      final titles = ['Sent to Taher Ankleshwaria', 'Recieved from Namra Patel', 'Recieved from Taher Ankleshwaria', 'Sent to Shehab Salem',
      'Recieved from Taher Ankleshwaria', 'Sent to Namra Patel',];
      final amount =['-\$300.00', '+\$100.00', '+\$50.00', '-\$121.00',
                    '+\$32.00', '-\$200.00', ];

      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(titles[index], style: TextStyle(color: Colors.black),),
            leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent[700],
                          ),
            trailing: Text(amount[index], style: TextStyle(color: Colors.black),),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );



    }


}

class ClickPerMonth {
  final String month;
  final int clicks;
  final charts.Color color;

  ClickPerMonth(this.month, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
            
}