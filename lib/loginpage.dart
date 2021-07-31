import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/mainpage.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class myloginpage extends StatefulWidget {
  @override
  _myloginpageState createState() => _myloginpageState();
}

class _myloginpageState extends State<myloginpage> {
  final _auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController nameController1 = TextEditingController();
  String UserName = '', password = '';
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
                      padding: EdgeInsets.only(top: 120),
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
                Container(
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone number, username or email',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (text) {
                        setState(() {
                          //UserName = text;
                          UserName = nameController.text;
                        });
                      },
                    )),
                Container(
                    padding: EdgeInsets.only(bottom: 10),
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      obscureText: (mychecky == false) ? false : true,
                      controller: nameController1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (text) {
                        setState(() {
                          //password = text;
                          password = nameController1.text;
                        });
                      },
                    )),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: mychecky,
                          onChanged: (bool value) {
                            setState(() {
                              mychecky = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(right: 50),
                            child: Text(
                              'Hide Password',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ))
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Forgot Password?',
                          style:
                              TextStyle(color: Colors.lightBlue, fontSize: 20),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 380,
                  height: 60,
                  // ignore: deprecated_member_use
                  child: Builder(
                      builder: (context) => FlatButton(
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                            onPressed: () async {
                              try {
                                final newuser =
                                    await _auth.signInWithEmailAndPassword(
                                        email: UserName, password: password);
                                print(UserName);
                                print(password);
                                if (newuser != null) {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation, secondaryAnimation) =>
                                            mymainpage(),
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
                                }
                              } catch (err) {
                                return showDialog(
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
                              }
                            },
                          )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.lightBlue),
                ),
                SizedBox(
                  height: 30,
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
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.facebookSquare,
                      color: Colors.lightBlue,
                    ),
                    Text(
                      '   Log in With Facebook',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Divider(
                  color: Colors.grey[400],
                  height: 20,
                  thickness: 1,
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      Builder(
                        builder: (context) => FlatButton(
                          child: Text(
                            'Sign Up.',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        mysignuppage(),
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
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
