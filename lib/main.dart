import 'package:flutter/material.dart';

//pages
import 'homepage.dart';
import 'loginpage.dart';
import 'signuppage.dart';
import 'profilepage.dart';
import 'groupspage.dart';




void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Funder",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  TabController controller;

  @override
    void initState() {
      super.initState();
      controller = new TabController(vsync: this, length: 4);
    }

    @override
      void dispose() {
        super.dispose();
        controller.dispose();
      }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
         color: Colors.white,
         child: TabBar(
           controller: controller,
           indicatorColor: Colors.blue,
           indicatorSize: TabBarIndicatorSize.tab,
           indicatorWeight: 5.0,
           tabs: <Widget>[
             Tab(icon: Icon(Icons.home, color: Colors.grey,),),
             Tab(icon: Icon(Icons.group, color: Colors.grey,),),
             Tab(icon: Icon(Icons.person_outline, color: Colors.grey,),),
           ],
         ),
       ), 
       body: TabBarView(
         controller: controller,
         children: <Widget>[
           HomePage(),
           GroupsPage(),
           ProfilePage(),
         ],
       ),
    );
  }
}