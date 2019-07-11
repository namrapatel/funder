import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class viewCardsPage extends StatefulWidget {
  @override
  _viewCardsPageState createState() => _viewCardsPageState();
}

class _viewCardsPageState extends State<viewCardsPage> {
  final screenH = ScreenUtil.instance.setHeight;
  final screenW = ScreenUtil.instance.setWidth;
  final screenF = ScreenUtil.instance.setSp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenH(100)), 
        child: AppBar(
          leading: IconButton(icon: Icon(Icons.close), color: Colors.white, onPressed: (){
            Navigator.pop(context);
          },),
          backgroundColor: Colors.black,
          title: Text("Your Cards"),
          elevation: 0,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _myListView(context),
          )
        ],
      ),
    );
  }
  Widget _myListView(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(SimpleLineIcons.credit_card),
          trailing: Icon(SimpleLineIcons.trash),
          title: Text('TD Personal ****1234'),  
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
