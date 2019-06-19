import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'homepage.dart';
import 'screens/RequestsScreen.dart';
import 'screens/PastScreen.dart';
import 'screens/ChatScreen.dart';

class GroupsDetailPage extends StatelessWidget {
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
              actions: <Widget>[
                Spacer(),
                IconButton(
                  onPressed: () {},
                  iconSize: ScreenUtil.instance.setHeight(25.0),
                  color: Colors.white,
                  icon: Icon(Icons.more_vert),
                ),
              ],
              iconTheme: IconThemeData(color: Colors.white),
              expandedHeight: ScreenUtil.instance.setSp(200.0),
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Roommates",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil.instance.setSp(16.0),
                      )),
                  background: Stack(children: <Widget>[
                    Container(
                      // height: ScreenUtil.instance.setHeight(235.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [firstColor, secondColor],
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 90,
                          ),
                          Center(
                            child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/roommates.jpeg'),
                                radius: 50),
                          ),
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
                  indicatorColor: Colors.greenAccent[700],
                  tabs: [
                    Tab(
                        icon: Icon(Icons.inbox, color: Colors.greenAccent[700]),
                        text: "Requests"),
                    Tab(
                        icon:
                            Icon(Icons.history, color: Colors.greenAccent[700]),
                        text: "History"),
                    Tab(
                        icon: Icon(Icons.chat, color: Colors.greenAccent[700]),
                        text: "Chat"),
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
