import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorldPage extends StatefulWidget {
  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
          height: 260.0,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),),
              Text("Invite your Friends", style: TextStyle(fontSize: 20, color: Colors.black), ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Text("Dime is better with friends! Invite your friends and earn bonus cash back.", style: TextStyle(fontSize: 15, color: Colors.grey), textAlign: TextAlign.center, ),
              ),
              // Spacer(),
              Row(
                children: <Widget>[
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: Color(0xFF0078FF),
                    elevation: 7,
                    child: Icon(MaterialCommunityIcons.facebook_messenger, size: 28,),
                    onPressed: (){},
                  ),
                  Spacer(),
                    FloatingActionButton(
                    backgroundColor: Color(0xFF25d366),
                    elevation: 7,
                    child: Icon(MaterialCommunityIcons.whatsapp, color: Colors.white, size: 28,),
                    onPressed: (){},
                  ),
                  Spacer(),
                    FloatingActionButton(
                    backgroundColor: Color(0xFFDB4437),
                    elevation: 7,
                    child: Icon(MaterialCommunityIcons.email_open_outline, color: Colors.white, size: 28),
                    onPressed: (){},
                  ),
                  Spacer(),
                    FloatingActionButton(
                    backgroundColor: Colors.grey[50],
                    elevation: 5,
                    child: Icon(Ionicons.ios_text, color: Colors.blueAccent[700], size: 28),
                    onPressed: (){},
                  ),

                  Spacer(),


                ],
              ),
              Spacer(),

              Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: TextField(
              onChanged: (value) {},
              //controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search or Add Friends",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 0.0),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)))),
            ),
              ),
              // Spacer(),
            ],
          ),
          ),
      DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(tabs: [Tab(icon: Icon(AntDesign.contacts,),), Tab(icon: Icon(Zocial.facebook, size: 22,),)],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              
              ),
              Container(
                  height: 815, 
                  child: TabBarView(
                    children: [
                      _myListView(context),
                      _myListView2(context)
                      ],
                  ))
            ],
          ))
    ]);
  }

  Widget _myListView(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      itemCount: 15,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/dhruvpatel.jpeg'),
          ),
          title: Text('Person $index'),
          trailing: SizedBox(
          width: 35.0,
          height: 35.0,
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.black,
            child: Icon(Icons.done, size: 15,),
            onPressed: () {},
          ),
        ),
          subtitle: Text("(123) 456-7890",
              style: TextStyle(
                fontSize: screenF(13),
              )),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey[500],
        );
      },
    );
  }
  Widget _myListView2(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      itemCount: 15,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/dhruvpatel.jpeg'),
          ),
          title: Text('Person $index'),
          trailing: SizedBox(
          width: 35.0,
          height: 35.0,
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.black,
            child: Icon(Icons.add, size: 15,),
            onPressed: () {},
          ),
        ),
          subtitle: Text("(123) 456-7890",
              style: TextStyle(
                fontSize: screenF(13),
              )),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey[500],
        );
      },
    );
  }
}
