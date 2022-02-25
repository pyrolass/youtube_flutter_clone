import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_clone/model/video.dart';
import 'package:youtube_clone/provider/current_video.dart';
import 'package:youtube_clone/provider/miniplayer_provider.dart';

class VideoCard extends StatelessWidget {
  final Video video;
  final bool hasPadding;
  final VoidCallback? onTap;
  const VideoCard({
    Key? key,
    required this.video,
    this.hasPadding = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<CurrentVideo, MiniplayerProvider>(
      builder: (context, vidProvider, miniProvider, _) {
        return GestureDetector(
          onTap: () {
            vidProvider.assignVideo(video);
            miniProvider.controller.animateToHeight(state: PanelState.MAX);

            if (onTap != null) {
              onTap!();
            }
          },
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: hasPadding ? 4 : 0),
                    child: Image.network(
                      video.thumbnailUrl,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: hasPadding ? 20 : 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      color: Colors.black,
                      child: Text(
                        video.duration,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onDoubleTap: () => print('object'),
                      child: CircleAvatar(
                        foregroundImage: NetworkImage(
                          video.author.profileImageUrl,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              video.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 15),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '${video.author.username} • ${video.viewCount} views • ${timeago.format(video.timestamp)}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.more_vert,
                        size: 20,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
