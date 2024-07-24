// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:checkedln/global.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class MoreStories extends StatefulWidget {
  List<String?>? imageList;
  MoreStories({
    Key? key,
    this.imageList,
  }) : super(key: key);
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  _MoreStoriesState();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        onVerticalSwipeComplete: (p0) => Navigator.of(context).pop(),
        storyItems: [
          for (int i = 0; i < widget.imageList!.length; i++) ...[
            StoryItem.pageImage(
              url: widget.imageList![i]!,
              controller: storyController,
            ),
          ]
        ],
        onStoryShow: (storyItem, index) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
          Navigator.of(context).pop();
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}
