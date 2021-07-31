import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'mainpage.dart';

final controller = StoryController();

class Mybodyview extends StatefulWidget {
  @override
  _MybodyviewState createState() => _MybodyviewState();
}

class _MybodyviewState extends State<Mybodyview> {
  List<StoryItem> storyItems = [
    StoryItem.text(
        backgroundColor: Colors.black87,
        title: 'Instagram',
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Billabong',
            fontSize: 80)),
    StoryItem.pageImage(
        url: 'https://media1.popsugar-assets.com/files/thumbor/Owrrx3OsGwFXTUKFQico6Bmjv5Y/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2016/01/11/797/n/1922153/940d7f6ffea5ccb7_grid-cell-30798-1452255774-1/i/Photos-People-Freckles.jpg',
        controller: controller),
    StoryItem.pageImage(
        url: 'https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif',
        controller: controller),
    StoryItem.pageImage(
      url: 'https://media.giphy.com/media/pI2paNxecnUNW/giphy.gif',
      controller: controller,
    )
  ];

  myalert(s) {
    _MybodyviewState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Container(
                height: 800,
                width: 400,
                child: Builder(
                  builder: (context) => StoryView(
                      storyItems: storyItems,
                      controller: controller, // pass controller here too
                      repeat: true, // should the stories be slid forever
                      onStoryShow: (s) {
                        myalert(s);
                      },
                      onComplete: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return mymainpage();
                        }));
                      },
                      onVerticalSwipeComplete: (direction) {
                        if (direction == Direction.down) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return mymainpage();
                          }));
                        }
                      } // To disable vertical swipe gestures, ignore this parameter.
                      // Preferrably for inline story view.
                      ),
                ),
              ),
            )));
  }
}
