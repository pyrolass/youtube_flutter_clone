import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';

class MiniplayerProvider with ChangeNotifier {
  final MiniplayerController _controller = MiniplayerController();

  MiniplayerController get controller => _controller;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
