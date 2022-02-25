import 'package:flutter/material.dart';
import 'package:youtube_clone/model/video.dart';

class CurrentVideo with ChangeNotifier {
  Video? _currentVideo;

  Video? get curretnVideo => _currentVideo;

  void assignVideo(Video video) {
    _currentVideo = video;
    notifyListeners();
  }

  void unselectVideo() {
    _currentVideo = null;
    notifyListeners();
  }
}
