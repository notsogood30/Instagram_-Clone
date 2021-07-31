import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'mainpage.dart';

final controller = StoryController();

class Mybodyview2 extends StatefulWidget {
  @override
  _Mybodyview2State createState() => _Mybodyview2State();
}

class _Mybodyview2State extends State<Mybodyview2> {
  List<StoryItem> storyItems = [
    StoryItem.text(
        backgroundColor: Colors.black87,
        title: 'Instagram',
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Billabong',
            fontSize: 80)),
    StoryItem.pageImage(
        url: 'https://cpng.pikpng.com/pngl/s/1-16071_group-of-people-walking-png-group-people-walking.png',
        controller: controller),
    StoryItem.pageImage(
        url: 'https://www.freedigitalphotos.net/images/category-images/96.jpg',
        controller: controller),
    StoryItem.pageImage(
      url: 'https://i.pinimg.com/474x/e7/cf/8a/e7cf8a8a344674bcc1145dec1a90ab6d.jpg',
      controller: controller,
    )
  ];

  myalert(s) {
    _Mybodyview2State();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
