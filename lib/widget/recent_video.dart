import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/model/video.dart';
import 'package:youtube_clone/provider/current_video.dart';
import 'package:youtube_clone/provider/miniplayer_provider.dart';

class RecentVideo extends StatelessWidget {
  final Video video;
  final VoidCallback? onTap;

  const RecentVideo({
    Key? key,
    required this.video,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: 200,
      child: Consumer2<CurrentVideo, MiniplayerProvider>(
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
                    Image.network(
                      video.thumbnailUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
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
                const LinearProgressIndicator(
                  value: 0.4,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                              video.author.username,
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
