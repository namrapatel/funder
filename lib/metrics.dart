import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MetricsPage extends StatefulWidget {
  @override
  _MetricsPageState createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  Color primaryColor = Color.fromRGBO(255, 82, 48, 1);

  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  @override
  Widget build(BuildContext context) {
    var data = [
      CategoryTrans('Dining', 30, Colors.purple),
      CategoryTrans('Leisure', 42, Colors.blue),
      CategoryTrans('Rent', 54, Colors.orange),
      CategoryTrans('Groceries', 20, Colors.green),
      CategoryTrans('Transport', 76, Colors.yellow),
      //CategoryTrans('Jun', 35, Colors.blue),
    ];
      var data2 = [
        MonthlyTrans(1, 5),
        MonthlyTrans(2, 15),
        MonthlyTrans(3, 25),
        MonthlyTrans(4, 35),
        MonthlyTrans(5, 15),
        MonthlyTrans(6, 5),
        MonthlyTrans(7, 7),
        MonthlyTrans(8, 95),
        MonthlyTrans(9, 55),
        MonthlyTrans(10, 15),
        MonthlyTrans(11, 45),
        MonthlyTrans(12, 65),
    ];


    var series2= [
        new charts.Series<MonthlyTrans, int>(
        id: 'Trans',
        colorFn: (_, __) => charts.MaterialPalette.black,
        domainFn: (MonthlyTrans trans, _) => trans.month,
        measureFn: (MonthlyTrans trans, _) => trans.trans,
        data: data2,
      )
    ];


    var series = [
      new charts.Series(
          id: 'Clicks',
          outsideLabelStyleAccessorFn: (CategoryTrans clickData, _) {
            return new charts.TextStyleSpec(color: charts.MaterialPalette.black);
          },
          domainFn: (CategoryTrans clickData, _) => clickData.category,
          measureFn: (CategoryTrans clickData, _) => clickData.amount,
          colorFn: (CategoryTrans clickData, _) => clickData.color,
          data: data),
    ];

    var chart2 = new charts.LineChart(series2,
    animate: true,  animationDuration: Duration(milliseconds: 1000)
    );
    var chartWidget2 = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        height: 180.0,
        child: chart2,
      ),
    );



    var chart = new charts.BarChart(series,

        animate: true,  animationDuration: Duration(milliseconds: 1000));

    var chartWidget =Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(height: 180.0, child: chart),
    );



    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenH(100)), 
        child: AppBar(
          leading: IconButton(icon: Icon(Icons.close), color: Colors.white, onPressed: (){
            Navigator.pop(context);
          },),
          backgroundColor: Colors.black,
          title: Text("Metrics"),
          elevation: 0,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: double.infinity,
                height: 370.0,
                decoration: BoxDecoration(
                    color: Colors.white,
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
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Category Transactions',
                                style: TextStyle(
                                  color: Colors.black,
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
            ),
            SizedBox(height: 25.0),
          ],
        ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: double.infinity,
                height: 370.0,
                decoration: BoxDecoration(
                    color: Colors.white,
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
                                    color: Colors.black,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Monthly Transactions',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    chartWidget2,

                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 30.0),
            ),
            SizedBox(height: 25.0),

        ],
 
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
            backgroundColor: Colors.black,
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

class CategoryTrans {
  final String category;
  final double amount;
  final charts.Color color;

  CategoryTrans(this.category, this.amount, Color color)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);

}

class MonthlyTrans {
  final int month;
  final int trans;

  MonthlyTrans(this.month, this.trans);
}

