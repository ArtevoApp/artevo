import 'package:flutter/foundation.dart';

class MusicPlayerController extends ChangeNotifier {
  MusicPlayerController._();

  static final MusicPlayerController instance = MusicPlayerController._();

  bool _showMusicPlayer = false;

  bool get isShowMusicPlayer => _showMusicPlayer;

  void init() {
    _showMusicPlayer = true;
    notifyListeners();
  }

  void hideMusicPlayer() {
    _showMusicPlayer = false;
    notifyListeners();
  }

  void showMusicPlayer() {
    _showMusicPlayer = true;
    notifyListeners();
  }
}
