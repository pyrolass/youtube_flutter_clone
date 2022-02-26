import 'package:flutter/material.dart';
import 'package:youtube_clone/model/user.dart';
import 'package:youtube_clone/model/video.dart';
import 'package:youtube_clone/widget/widgets.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset('assets/yt_logo_dark.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cast),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            iconSize: 40,
            onPressed: () {},
            icon: CircleAvatar(
              foregroundImage: NetworkImage(
                currentUser.profileImageUrl,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      return RecentVideo(video: video);
                    },
                    itemCount: videos.length,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textButtons(
                        context,
                        'History',
                        Icons.history,
                      ),
                      textButtons(
                        context,
                        'Your video',
                        Icons.play_arrow_outlined,
                      ),
                      textButtons(
                        context,
                        'Downloads',
                        Icons.download_outlined,
                      ),
                      textButtons(
                        context,
                        'Your movies',
                        Icons.local_movies_outlined,
                      ),
                      textButtons(
                        context,
                        'Watch later',
                        Icons.history_edu_outlined,
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Playlist',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Row(
                        children: [
                          Text(
                            'Recently added',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          IconButton(
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            onPressed: () {},
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'New playlist',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.blue),
                          ),
                        ],
                      ),
                      textButtons(
                          context, 'Like videos', Icons.thumb_up_alt_outlined)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textButtons(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
