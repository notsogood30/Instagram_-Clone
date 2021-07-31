import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mainpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class mysignuppage extends StatefulWidget {
  @override
  _mysignuppageState createState() => _mysignuppageState();
}

class _mysignuppageState extends State<mysignuppage> {
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  final _auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController nameController3 = TextEditingController();
  String UserName = '', password = '', email = '', fullname = '';
  bool mychecky = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      //color: Colors.yellow,
                      padding: EdgeInsets.only(top: 80),
                      child: Center(
                        child: Text(
                          'Instagram',
                          style: TextStyle(
                              fontFamily: 'Billabong',
                              fontSize: 85,
                              fontWeight: FontWeight.w200,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Sign up to see photos and videos',style: TextStyle(color: Colors.grey[500],fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('from your friends',style: TextStyle(color: Colors.grey[500],fontSize: 20,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: 380,
                    height: 50,
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.facebookSquare,color: Colors.white,),
                          Text(
                            '  Login in with Facebook',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      onPressed: (){},
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.lightBlue),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      height: 20,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      height: 20,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                ]),
                Container(
                    margin: EdgeInsets.fromLTRB(15, 25, 15, 5),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (text) {
                        setState(() {
                          //UserName = text;
                          email = nameController.text;
                        });
                      },
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextField(
                      controller: nameController1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (text) {
                        setState(() {
                          //password = text;
                          fullname = nameController1.text;
                        });
                      },
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: TextField(
                      controller: nameController2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (text) {
                        setState(() {
                          //UserName = text;
                          UserName = nameController2.text;
                        });
                      },
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 25),
                    child: TextField(
                      obscureText: (mychecky == false) ? false : true,
                      controller: nameController3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (text) {
                        setState(() {
                          //password = text;
                          password = nameController3.text;
                        });
                      },
                    )),
                Container(
                  width: 380,
                  height: 50,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: ()async{
                      try{
                        print(UserName);
                        String myname = UserName;
                        final newuser = await _auth.createUserWithEmailAndPassword(
                            email: email, password: password).then((result) {
                          dbRef.child(result.user.uid).set({
                          "email": email,
                          "fullname": fullname,
                          "username": UserName
                          }).then((res) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) =>
                                      mymainpage(username: myname,),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = Offset(0.0, 1.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;
                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);
                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                  transitionDuration: Duration(seconds: 2)
                              ),
                            );
                          });
                        }).catchError((err) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text(err.message),
                                  actions: [
                                    TextButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        });
                      }
                      catch(e)
                      {
                        print(e);
                      }
                    },
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.lightBlue),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('By signing up, you agree to our',style: TextStyle(color: Colors.grey[500],fontSize: 20),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Terms & Privacy Policy.',style: TextStyle(color: Colors.grey[500],fontSize: 20,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
