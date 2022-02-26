import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/provider/current_video.dart';
import 'package:youtube_clone/provider/miniplayer_provider.dart';
import 'package:youtube_clone/screen/home_screen.dart';
import 'package:youtube_clone/screen/library_screen.dart';
import 'package:youtube_clone/screen/sub_screen.dart';
import 'package:youtube_clone/screen/video_screen.dart';

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
    const SubScreen(),
    const LibraryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<CurrentVideo, MiniplayerProvider>(
        builder: (context, vidProvider, miniProvider, _) {
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
                  offstage: vidProvider.curretnVideo == null,
                  child: Miniplayer(
                    controller: miniProvider.controller,
                    minHeight: _playerMinHeight,
                    maxHeight: MediaQuery.of(context).size.height,
                    builder: (height, percentage) {
                      if (vidProvider.curretnVideo == null) {
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
                                    vidProvider.curretnVideo!.thumbnailUrl,
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
                                              vidProvider.curretnVideo!.title,
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
                                              vidProvider.curretnVideo!.author
                                                  .username,
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
                                      vidProvider.unselectVideo();
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
