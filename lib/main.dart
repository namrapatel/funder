import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//pages
import 'homepage.dart';
import 'profilepage.dart';
import 'groupspage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default Brightness and Colors
        backgroundColor: Colors.orange[400],
        primaryColor: Colors.blueAccent[400],
        accentColor: Colors.greenAccent[400],

        // Define the default Font Family
        fontFamily: 'Proxima Nova',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Proxima Nova'),
        ),
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
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.create),
            onPressed: () {
              _settingModalBottomSheet(context);
            },
          ),
        ],
        centerTitle: true,
        title: new Text('Funder', style: TextStyle(color: Colors.white)),
        elevation: 0.0,
        backgroundColor: Colors.blueAccent[400],
      ),
      // floatingActionButton: FloatingActionButton(
      //   elevation: 0.0,
      //   onPressed: () {
      //     _settingModalBottomSheet(context);
      //   },
      //   child: Icon(
      //     Icons.create,
      //   ),
      //   mini: true,
      // ),
      body: PageView(
        children: [
          Container(
            color: Colors.white,
            child: HomePage(),
          ),
          Container(color: Colors.white, child: GroupsPage()),
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
        activeColor: Colors.orange,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: (_page == 0) ? Colors.black : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.group,
                  color: (_page == 1) ? Colors.black : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: (_page == 2) ? Colors.black : Colors.grey),
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

//
Future navigateToGroupsPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => GroupsPage()));
}
