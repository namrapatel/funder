import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:funder/worldpage.dart';
import 'signuppage.dart';
import 'homepage.dart';
import 'loginpage.dart';
import 'profilepage.dart';
import 'notificationspage.dart';
import 'worldpage.dart';
import 'screens/groupTransaction.dart';
import 'screens/loginScreen.dart';

void main() => runApp(Dime());

class Dime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dime",
      home: LoginScreen(),
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => new MyHomePage(),
        '/loginpage': (BuildContext context) => new LoginPage(),
        '/signuppage': (BuildContext context) => new SignupPage(),
        '/profilepage': (BuildContext context) => new ProfilePage(),
      },
      theme: appTheme,
    );
  }
}

ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],
    primaryColor: Colors.blueAccent[700],
    fontFamily: 'Varela');

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  PageController pageController;

// This widget builds the bottom app bar using a PageView widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: Colors.white,
            child: HomePage(),
          ),
          Container(
            color: Colors.white,
            child: WorldPage(),
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
// Creating the actual bottom app bar using the CupertinoTabBar widget.
      bottomNavigationBar: CupertinoTabBar(
        activeColor: Colors.greenAccent[700],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: (_page == 0) ? Colors.blueAccent[700] : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore,
                  color: (_page == 1) ? Colors.blueAccent[700] : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications,
                  color: (_page == 2) ? Colors.blueAccent[700] : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: (_page == 3) ? Colors.blueAccent[700] : Colors.grey),
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
