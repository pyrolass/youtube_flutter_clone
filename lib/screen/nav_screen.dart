import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miniplayer/miniplayer.dart';

import 'package:youtube_clone/model/video.dart';
import 'package:youtube_clone/screen/home_screen.dart';
import 'package:youtube_clone/screen/video_screen.dart';

final selectedVideoProvider = StateProvider<Video?>((ref) => null);
final miniplayerControllerProvider =
    StateProvider.autoDispose<MiniplayerController>(
        (ref) => MiniplayerController());

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  static const double _playerMinHeight = 60.0;
  int _selectedIndex = 0;

  final _screens = [
    const HomeScreen(),
    const Scaffold(
      body: Center(
        child: Text('data'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('data2'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('data3'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('data4'),
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, _) {
          final _selectedVideo = watch(selectedVideoProvider).state;
          final _miniPlayerController =
              watch(miniplayerControllerProvider).state;
          return Stack(
            children: _screens
                .asMap()
                .map(
                  (index, screen) => MapEntry(
                    index,
                    Offstage(
                      offstage: _selectedIndex != index,
                      child: screen,
                    ),
                  ),
                )
                .values
                .toList()
              ..add(
                Offstage(
                  offstage: _selectedVideo == null,
                  child: Miniplayer(
                    controller: _miniPlayerController,
                    minHeight: _playerMinHeight,
                    maxHeight: MediaQuery.of(context).size.height,
                    builder: (height, percentage) {
                      if (_selectedVideo == null) {
                        return const SizedBox.shrink();
                      }
                      if (height <= _playerMinHeight + 50) {
                        return Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    _selectedVideo.thumbnailUrl,
                                    height: _playerMinHeight - 4.0,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              _selectedVideo.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              _selectedVideo.author.username,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.play_arrow),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read(selectedVideoProvider)
                                          .state = null;
                                    },
                                    icon: const Icon(Icons.close),
                                  )
                                ],
                              ),
                              const LinearProgressIndicator(
                                value: 0.4,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              )
                            ],
                          ),
                        );
                      }
                      return const VideoScreen();
                    },
                  ),
                ),
              ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explicit_outlined,
            ),
            activeIcon: Icon(Icons.explicit),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.subscriptions_outlined,
            ),
            activeIcon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_label_outlined,
            ),
            activeIcon: Icon(Icons.video_library),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}
