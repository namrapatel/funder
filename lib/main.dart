import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//pages
import 'homepage.dart';
import 'profilepage.dart';
import 'notificationspage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.dark,
        // Define the default Brightness and Colors
        backgroundColor: Colors.greenAccent[400],
        primaryColor: Colors.greenAccent[400],
        accentColor: Colors.greenAccent[400],
        // Define the default Font Family
        fontFamily: 'Varela',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        // textTheme: TextTheme(
        //   headline: TextStyle(
        //       fontSize: 72.0,
        //       fontWeight: FontWeight.bold,
        //       fontFamily: 'Varela'),
        //   title: TextStyle(
        //       fontSize: 36.0,
        //       fontStyle: FontStyle.italic,
        //       fontFamily: 'Varela'),
        //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Varela'),
        // ),
      ),
      title: "Funder",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: Colors.white,
            child: HomePage(),
          ),
          Container(color: Colors.white, child: NotificationsPage()),
          Container(
            color: Colors.white,
            child: ProfilePage(),
          ),
        ],
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
      
      bottomNavigationBar: CupertinoTabBar(
        activeColor: Colors.greenAccent[400],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: (_page == 0) ? Colors.greenAccent[400] : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications,
                  color: (_page == 1) ? Colors.greenAccent[400] : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: (_page == 2) ? Colors.amber[800] : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 0.0, 10.0),
                  leading: new Icon(Icons.call_split),
                  title: new Text('Split a Payment'),
                  subtitle: new Text(
                      'Request to split a payment between a group of people.'),
                  onTap: () => {}),
              new Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              new ListTile(
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 0.0, 20.0),
                  leading: new Icon(Icons.send),
                  title: new Text('Send to Contact'),
                  subtitle: new Text(
                      'Send money to individuals on your friends list.'),
                  onTap: () => {}),
            ],
          ),
        );
      });
}

