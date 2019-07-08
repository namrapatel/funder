import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signuppage.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Dime/classes/user.dart';

User currentUserModel;
FacebookLogin fbLogin = new FacebookLogin();
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

bool _isLoggedIn=false;
Map userProfile;
   final _auth = FirebaseAuth.instance;


   TextEditingController _smsCodeController = TextEditingController();
   TextEditingController _phoneNumberController = TextEditingController();
   String verificationId;



  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) async{
      if(firebaseUser != null){
        print(firebaseUser);
        print(firebaseUser.displayName);
        print("you're in");

        DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(firebaseUser.uid).get();


        currentUserModel=  User.fromDocument(userRecord);
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyHomePage()));
      }
      else{
        print("floppps");
      }
    });



   final _auth = FirebaseAuth.instance;



  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool checkValue = false;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    getCredential();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new TextFormField(
                    onEditingComplete: onEdit,
                    controller: username,
                    decoration: InputDecoration(
                        hintText: "username",
                        hintStyle: new TextStyle(color: Colors.grey.withOpacity(0.3))),
                  ),
                  new TextFormField(
                      onEditingComplete: onEdit,
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "password",
                          hintStyle:
                          new TextStyle(color: Colors.grey.withOpacity(0.3)))),
                  new CheckboxListTile(
                    value: checkValue,
                    onChanged: _onChanged,
                    title: new Text("Remember me"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(height: 15.0),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: signIn,
                    child: Text('Login'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,

                  ),

                  SizedBox(height: 15.0),
                  Text('Don\'t have an account?'),
                  SizedBox(height: 10.0),
                  RaisedButton(

                    onPressed:() async{
                      FacebookLoginResult result = await fbLogin.logInWithReadPermissions(['email','public_profile','user_friends']);




                      final FacebookAccessToken accessToken = result.accessToken;

                      AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: accessToken.token);

                      FirebaseUser user = await _auth.signInWithCredential(credential);

                      switch (result.status) {
                        case FacebookLoginStatus.loggedIn:
                          final token = accessToken.token;
                          print(token);
                          print(accessToken.expires);
//                          final pic =await http.get('http://graph.facebook.com/[user_id]/picture?type=square');
                          final graphResponse = await http.get('https://graph.facebook.com/v3.3/me?fields=name,picture.width(800).height(800),email&access_token=${token}');
                          print(graphResponse);
                          final profile = JSON.jsonDecode(graphResponse.body);
                          print(profile);
                          setState(() {
                            userProfile = profile;
                            _isLoggedIn = true;
                          });
                          break;

                        case FacebookLoginStatus.cancelledByUser:
                          setState(() => _isLoggedIn = false );
                          break;
                        case FacebookLoginStatus.error:
                          setState(() => _isLoggedIn = false );
                          break;
                      }


//                  print(userProfile["friends"]['data'][0]['id']);
//                      List<String> fbFriendsIds=[];
//                      for(var key in userProfile["friends"]['data']){
//                        String fbId= key['id'];
//                        fbFriendsIds.add(fbId);
//                      }
//                      print(fbFriendsIds);
                      DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(user.uid).get();
                      if(!userRecord.exists){
                        Firestore.instance.collection('users').document(user.uid).setData({
                          'photoUrl':userProfile["picture"]["data"]["url"],
                          'email': user.email,
                          'displayName': user.displayName,
                          'phoneNumber': user.phoneNumber,
                          'facebookUid':user.providerData[1].uid,
//                          'fbFriends': fbFriendsIds
                          //after getting friends who have the app, query for their document using their
                          //fb uid and then display their name and photo url on contacts

                        });
                        userRecord=await Firestore.instance.collection('users').document(user.uid).get();
                      }
                      print(user.uid);

                      currentUserModel=  User.fromDocument(userRecord);
                      print('signed in with facebook successful: user -> $user');
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyHomePage()));

                        }


                    ,

                    child: Text('Log in with Facebook'),

                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignupPage()));
                    },
                  ),
                ],
              )),
        ));
  }

  void onEdit(){
    if(username.text.length!=0) {
      _email = username.text;
    }
    if(password.text.length!=0) {
      _password = password.text;
    }
  }
  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", username.text);
      sharedPreferences.setString("password", password.text);
    });
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check");
      print(checkValue);
      if (checkValue != null) {
        if (checkValue) {
          username.text = sharedPreferences.getString("username");
          password.text = sharedPreferences.getString("password");
          signIn();
        } else {
          username.clear();
          password.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }


  Future<void> signIn() async{
    if(username.text.length!=0 && password.text.length!=0) {
      _email = username.text;
      _password = password.text;
    }
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email , password: _password);
       FirebaseUser user =await _auth.currentUser();
        DocumentSnapshot userRecord= await Firestore.instance.collection('users').document(user.uid).get();
        print(user.uid);
        currentUserModel=  User.fromDocument(userRecord);
        print(currentUserModel.uid);
        print('login aove');
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage()));
      }catch(e){
        print(e);

      }
    }

  }

}