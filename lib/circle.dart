import 'package:dashed_circle/dashed_circle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'mybodyview.dart';
import 'mybodyview1.dart';
import 'mybodyview2.dart';
import 'package:social_media_widgets/instagram_story_swipe.dart';
import 'myprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

String myusername;

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  DatabaseReference dbRef = FirebaseDatabase.instance
      .reference()
      .child("Users")
      .child(FirebaseAuth.instance.currentUser.uid);
  final firestoreInstance = FirebaseFirestore.instance;
  IconData myicon = Icons.favorite_border;
  Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
  /// Variables
  Animation gap;
  Animation base;
  Animation reverse;
  AnimationController controller;
  ImageLoadingBuilder loadingBuilder;

  /// Init
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 100));
    base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);
    gap = Tween<double>(begin: 3.0, end: 0.0).animate(base)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    print(myTimeStamp.toDate());
  }

  /// Dispose
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Container(
                height: 110,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, right: 5, left: 8),
                          child: RotationTransition(
                            turns: base,
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InstagramStorySwipe(
                                        children: <Widget>[
                                          Mybodyview(),
                                          Mybodyview1(),
                                          Mybodyview2(),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: DashedCircle(
                                gapSize: gap.value,
                                dashes: 40,
                                color: Colors.blue,
                                child: RotationTransition(
                                  turns: reverse,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage: NetworkImage(
                                          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, right: 5),
                          child: RotationTransition(
                            turns: base,
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InstagramStorySwipe(
                                        children: <Widget>[
                                          Mybodyview1(),
                                          Mybodyview(),
                                          Mybodyview2(),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: DashedCircle(
                                gapSize: gap.value,
                                dashes: 40,
                                color: Colors.red,
                                child: RotationTransition(
                                  turns: reverse,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage: NetworkImage(
                                          "https://images.unsplash.com/photo-1564564295391-7f24f26f568b"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: RotationTransition(
                            turns: base,
                            child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InstagramStorySwipe(
                                        children: <Widget>[
                                          Mybodyview2(),
                                          Mybodyview(),
                                          Mybodyview1(),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: DashedCircle(
                                gapSize: gap.value,
                                dashes: 40,
                                color: Colors.pink,
                                child: RotationTransition(
                                  turns: reverse,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage: NetworkImage(
                                          "https://images.ctfassets.net/hrltx12pl8hq/31f9j3A3xKasyUMMsuIQO8/6a8708add4cb4505b65b1cee3f2e6996/9db2e04eb42b427f4968ab41009443b906e4eabf-people_men-min.jpg?fit=fill&w=368&h=207"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 568,
              child: StreamBuilder(
                stream: firestoreInstance.collection('imagesetup').orderBy("date",descending: true).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData)
                    {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, i) {
                          return Container(
                            height: 600,
                            width: 500,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://www.colorhexa.com/89cff0.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                                      child: Text(
                                        snapshot.data.docs[i]['username'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 19),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: 15,
                                      child: Container(
                                          height: 400,
                                          width: 400,
                                          child: Image.network(
                                            snapshot.data.docs[i]['url'],
                                            loadingBuilder: (BuildContext context,
                                                Widget child,
                                                ImageChunkEvent loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  backgroundColor: Colors.grey,
                                                  strokeWidth: 6.0,
                                                  value: loadingProgress
                                                      .expectedTotalBytes !=
                                                      null
                                                      ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes
                                                      : null,
                                                ),
                                              );
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 50,
                                            child: Center(
                                              child: FlatButton(
                                                child: Icon(
                                                  myicon,
                                                  color: (myicon ==
                                                      Icons.favorite_border)
                                                      ? Colors.black
                                                      : Colors.red,
                                                  size: 35,
                                                ),
                                                onPressed: () {
                                                  if (myicon ==
                                                      Icons.favorite_border) {
                                                    setState(() {
                                                      myicon = Icons.favorite;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      myicon = Icons.favorite_border;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 50,
                                            //color:Colors.blue,
                                            child: Center(
                                              child: FlatButton(
                                                child: Icon(
                                                  FontAwesomeIcons.comment,
                                                  size: 30,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 50,
                                            child: Center(
                                              child: FlatButton(
                                                child: Icon(
                                                  Icons.send,
                                                  size: 30,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                                      child: Text(snapshot.data.docs[i]['username'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
                                    ),
                                    Container(
                                        padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                                        child: Text(snapshot.data.docs[i]['caption']))
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  else
                    {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                },
              ),
            ),
            Card(
              elevation: 20,
              child: Container(
                height: 62,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 40, left: 20),
                      child: Icon(
                        Icons.home_filled,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 40),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 40),
                      child: Icon(
                        Icons.video_collection_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 15),
                      child: Container(
                        width: 30,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                      ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return myprofile();
                          }));
                        },
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
