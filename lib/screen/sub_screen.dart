import 'package:flutter/material.dart';
import 'package:youtube_clone/model/video.dart';
import 'package:youtube_clone/widget/widgets.dart';

class SubScreen extends StatelessWidget {
  const SubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppbar(),
          const SubSliverAppbar(),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 60),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final video = videos[index];
                  return VideoCard(video: video);
                },
                childCount: videos.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
