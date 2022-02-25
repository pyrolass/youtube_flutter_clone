import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:youtube_clone/model/video.dart';
import 'package:youtube_clone/screen/nav_screen.dart';
import 'package:youtube_clone/widget/widgets.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController? _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read(miniplayerControllerProvider)
            .state
            .animateToHeight(state: PanelState.MAX);
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: CustomScrollView(
            controller: _scrollController,
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Consumer(
                  builder: (context, watch, _) {
                    final _selectedVideo = watch(selectedVideoProvider).state;
                    return SafeArea(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.network(
                                _selectedVideo!.thumbnailUrl,
                                height: 220,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  context
                                      .read(miniplayerControllerProvider)
                                      .state
                                      .animateToHeight(state: PanelState.MIN);
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                          const LinearProgressIndicator(
                            value: 0.4,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                          VideoInfo(video: _selectedVideo)
                        ],
                      ),
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final video = suggestedVideos[index];
                    return VideoCard(
                      video: video,
                      hasPadding: true,
                      onTap: () {
                        _scrollController!.animateTo(
                          0,
                          duration: const Duration(microseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                    );
                  },
                  childCount: suggestedVideos.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
