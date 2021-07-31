import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'mainpage.dart';

final controller = StoryController();

class Mybodyview1 extends StatefulWidget {
  @override
  _Mybodyview1State createState() => _Mybodyview1State();
}

class _Mybodyview1State extends State<Mybodyview1> {
  List<StoryItem> storyItems = [
    StoryItem.text(
        backgroundColor: Colors.black87,
        title: 'Instagram',
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Billabong',
            fontSize: 80)),
    StoryItem.pageImage(
        url: 'https://i.pinimg.com/236x/c5/e2/71/c5e271ec487200264fff8207aad737e4--the-maldives-writing-inspiration.jpg',
        controller: controller),
    StoryItem.pageImage(
        url: 'https://www.freedigitalphotos.net/images/category-images/397.jpg',
        controller: controller),
    StoryItem.pageImage(
      url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSk-tt0HjnjugX9xuQE3jcfHXsvoSTPqfYBfg&usqp=CAU',
      controller: controller,
    )
  ];

  myalert(s) {
    _Mybodyview1State();
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
