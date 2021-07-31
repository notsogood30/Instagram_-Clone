import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/circle.dart';
import 'package:instagram_clone/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class myprofile extends StatefulWidget {
  @override
  _myprofileState createState() => _myprofileState();
}

class _myprofileState extends State<myprofile> {
  final _auth = FirebaseAuth.instance;
  File myimage;
  String myusername;
  final firestoreInstance = FirebaseFirestore.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance
      .reference()
      .child("Users")
      .child(FirebaseAuth.instance.currentUser.uid);
  void initState() {
    dbRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      setState(() {
        myusername = values["username"].toString();
      });
    });
    firestoreInstance
        .collection("imagesetup")
        .where("username", isEqualTo: myusername)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        if(result.data()["username"]==myusername)
          {
            print(result.data());
          }
      });
    });
    //print(mylist);
  }
  List <String>mylist;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          leading: Icon(
            Icons.lock_outline,
            color: Colors.black,
            size: 40,
          ),
          title: Text(
            (myusername == null) ? 'text' : myusername,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: (myusername == null) ? Colors.white : Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.add_box_outlined,
                color: Colors.black,
                size: 40,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: (myimage == null)
                          ? Icon(
                              Icons.account_circle,
                              size: 100,
                            )
                          : Container(
                              width: 40,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(myimage), fit: BoxFit.fill),
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('0',
                                  style: TextStyle(
                                      fontSize: 40, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Posts', style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('0',
                                  style: TextStyle(
                                      fontSize: 40, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Followers', style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Following', style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(height: 120),
              Card(
                elevation: 20,
                child: Container(
                  width: 380,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.black, width: 1)),
                  child: FlatButton(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height:30,),
              StreamBuilder(
                  stream: firestoreInstance
                      .collection('imagesetup').orderBy("date").where("username", isEqualTo: myusername)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 2.0,
                            crossAxisSpacing: 2.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 150,
                              width: 100,
                              child: Image(
                                image: NetworkImage(
                                    snapshot.data.docs[index]["url"]),
                              ),
                            );
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  })
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 100,
                child: DrawerHeader(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 60,
                      ),
                      Text(
                        (myusername == null) ? 'text' : myusername,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 35,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onTap: () async {
                  await _auth.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return myloginpage();
                  }));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.update,
                      size: 35,
                    ),
                    Text(
                      'Archive',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onTap: () async {},
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      size: 35,
                    ),
                    Text(
                      'Your Activity',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onTap: () async {},
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.qr_code,
                      size: 35,
                    ),
                    Text(
                      'QR Code',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onTap: () async {},
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.turned_in_not,
                      size: 35,
                    ),
                    Text(
                      'Saved',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onTap: () async {},
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.format_list_bulleted_rounded,
                      size: 35,
                    ),
                    Text(
                      'Close Friends',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onTap: () async {},
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.person_add,
                      size: 35,
                    ),
                    Text(
                      'Discover People',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onTap: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
