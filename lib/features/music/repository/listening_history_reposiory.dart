import 'package:artevo_package/models/music_content.dart';
import 'package:flutter/material.dart';

import '../../../services/database/local/music_local_data_manager.dart';

class ListeningHistoryReposiory extends ChangeNotifier {
  ListeningHistoryReposiory._();
  static final instance = ListeningHistoryReposiory._();

  final _localDB = MusicLocalDataManager.instance;

  /// Get last listened musics.
  List<MusicContent> get listeningHistory => _listeningHistory;
  List<MusicContent> _listeningHistory = [];

  Future<void> init() async {
    final list = await _localDB.getLastListened();
    _listeningHistory = list.map(MusicContent.fromMap).toList();
    notifyListeners();
  }

  /// Add to history.
  Future<void> addToHistory(MusicContent music) async {
    try {
      await _localDB.addToLastListened(music.toMap());
      _listeningHistory.insert(0, music);
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  Future<void> clearHistory() async {
    await _localDB.clearLastListened();
    _listeningHistory.clear();
    notifyListeners();
  }
}
