import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/RequestsScreen.dart';
import 'screens/PastScreen.dart';
import 'screens/ChatScreen.dart';
import 'widgets/colorCard.dart';
import 'main.dart';

class GroupsDetailPage extends StatelessWidget {
  final int settleType = -1;
  final double balanceValue = 29.99;
  final greenSubStyle = TextStyle(
      color: Colors.greenAccent[700],
      fontSize: ScreenUtil(allowFontScaling: true).setSp(16.0));
  final redSubStyle = TextStyle(
      color: Colors.red,
      fontSize: ScreenUtil(allowFontScaling: true).setSp(16.0));
  final blackSubStyle = TextStyle(
      color: Colors.grey,
      fontSize: ScreenUtil(allowFontScaling: true).setSp(16.0));
  @override
  Widget build(BuildContext context) {
    double defaultScreenWidth = 414.0;
    double defaultScreenHeight = 896.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);
    return Scaffold(
        body: DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new MyHomePage()));
                },
              ),
              actions: <Widget>[
                Spacer(),
                IconButton(
                  onPressed: () {},
                  iconSize: ScreenUtil.instance.setHeight(25.0),
                  color: Colors.white,
                  icon: Icon(Icons.more_vert),
                ),
              ],
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              expandedHeight: ScreenUtil.instance.setHeight(300.0),
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  background: Stack(children: <Widget>[
                Container(
                  color: Colors.black,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/roommates.jpeg'),
                            radius: 50),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Roommates",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil.instance.setSp(25.0),
                          )),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 17,
                          ),
                          colorCard(
                              "Your Balance", 29.99, -1, context, Colors.white),
                          colorCard("Monthly Spending", 508.93, 1, context,
                              Colors.white)
                        ],
                      )
                    ],
                  ),
                )
              ])),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                        icon: Icon(Icons.inbox, color: Colors.black),
                       ),
                    Tab(
                        icon: Icon(Icons.history, color: Colors.black),
                        ),
                    Tab(
                        icon: Icon(Icons.chat, color: Colors.black),
                        ),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
            children: [RequestsScreen(), PastScreen(), GroupsChatScreen()]),
      ),
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
      color: Colors.white,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
