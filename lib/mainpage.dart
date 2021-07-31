import 'package:flutter/material.dart';
import 'package:instagram_clone/circle.dart';
import 'package:story_view/story_view.dart';
import 'circle.dart';
import 'imageupload.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

final controller = StoryController();

class mymainpage extends StatefulWidget {
  mymainpage({Key key, this.username}) : super(key: key);
  final String username;

  @override
  _mymainpageState createState() => _mymainpageState();
}

class _mymainpageState extends State<mymainpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          leading: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                          Myimageuploader(),
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
              child: Icon(Icons.add_box, color: Colors.black)),
            title:Center(
              child: Text(
                'Instagram',
                style: TextStyle(
                    fontFamily: 'Billabong',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            actions: [Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.message,
                color: Colors.black,
              ),
            ),],
      ),body: MyPage(),
    ));
  }
}
