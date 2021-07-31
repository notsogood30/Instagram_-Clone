import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'mainpage.dart';
import 'package:image_crop/image_crop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Myimageuploader extends StatefulWidget {
  @override
  _MyimageuploaderState createState() => _MyimageuploaderState();
}

class _MyimageuploaderState extends State<Myimageuploader> {
  User firebaseUser = FirebaseAuth.instance.currentUser;
  Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
  final picker = ImagePicker();
  final firestoreInstance = FirebaseFirestore.instance;
  TextEditingController captioncontroller = TextEditingController();
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users").child(FirebaseAuth.instance.currentUser.uid);
  String _uploadedFileURL;
  dynamic myusername;
  File _image;
  final cropKey = GlobalKey<CropState>();
  Future uploadImageToFirebase(BuildContext context,String username) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('uploads/${basename(_image.path)}}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        print(username);
        firestoreInstance.collection("imagesetup").add(
            {
              "caption" : captioncontroller.text,
              "url" : _uploadedFileURL,
              "username" : username,
              "date" : myTimeStamp,
            }).then((value){
          print(value.id);
          print(username);
          Navigator.pop(context);
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // ignore: deprecated_member_use
          leading: FlatButton(
            onPressed: () async{
              Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        mymainpage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = Offset(0.0, 1.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(seconds: 2)),
              );
            },
            child: Icon(
              Icons.arrow_back,
              size: 40,
            ),
          ),
          title: Text(
            'New Post',
            style: TextStyle(color: Colors.black87),
          ),
          actions: [
            FlatButton(
              onPressed: () async{
                dbRef.once().then((DataSnapshot snapshot) {
                  Map<dynamic, dynamic> values = snapshot.value;
                  setState(() {
                    //print(values["username"].toString());
                    uploadImageToFirebase(context,values["username"].toString());
                  });

                });
              },
              child: Icon(
                Icons.check,
                size: 40,
                color: Colors.blue,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Container(
                height: 700,
                width: 410,
                padding: EdgeInsets.only(top: 30),
                //color: Colors.blue,
                child: Column(
                  children: [
                    Row(children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            width: 80,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (_image!=null)?FileImage(_image):NetworkImage('https://www.colorhexa.com/89cff0.png'),
                                  fit: BoxFit.fill
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 30),
                            height: 30,
                            width: 300,
                            child: TextField(
                              controller: captioncontroller,
                              decoration: const InputDecoration(
                                hintText: 'Write a Caption...',
                                hintStyle: TextStyle(color: Colors.grey)
                              ),
                            ),
                          ),
                        ],
                      )
                    ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 50),
                          child: Card(
                            elevation: 30,
                            child: Container(
                              height: 350,
                              width: 400,
                              color: Colors.white,
                              child: (_image != null)
                                  ? Image(
                                      image: FileImage(_image),
                                      height: 200,
                                      width: 100,
                                    )
                                  : Icon(Icons.image,size: 100,),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Card(
                  child: Container(
                height: 50,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Column(children: [
                    FlatButton(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 60),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              size: 50,
                            ),
                            Text('Select Image')
                          ],
                        ),
                      ),
                      onPressed: () {
                        return showModalBottomSheet(
                            elevation: 20,
                            context: context,
                            builder: (BuildContext builder) {
                              return Container(
                                padding: EdgeInsets.only(left: 10),
                                height: 120,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(FontAwesomeIcons.images),
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          onPressed: () async {
                                            final pickedFile =
                                                await picker.getImage(
                                                    source: ImageSource.gallery);
                                            setState(() {
                                              if (pickedFile != null) {
                                                _image = File(pickedFile.path);
                                                Crop(
                                                  image: FileImage(_image),
                                                  aspectRatio: 4.0 / 3.0,
                                                );
                                                Navigator.pop(context);
                                              } else {
                                                print('No image selected.');
                                              }
                                            });
                                          },
                                          child: Text('Pick from Gallery'),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(FontAwesomeIcons.camera),
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          onPressed: () async {
                                            final pickedFile =
                                                await picker.getImage(
                                                    source: ImageSource.camera);
                                            setState(() {
                                              if (pickedFile != null) {
                                                _image = File(pickedFile.path);
                                                Crop(
                                                  image: FileImage(_image),
                                                  aspectRatio: 4.0 / 3.0,
                                                );
                                                Navigator.pop(context);
                                              } else {
                                                print("image not selcted");
                                              }
                                            });
                                          },
                                          child: Text('Capture with Camera'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ]),
                ]),
              ))
            ],
          )),
        ),
      ),
    );
  }
}
