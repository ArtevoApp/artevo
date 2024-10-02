import 'package:flutter/material.dart';

import '../../../services/cache/lazy_user_data_manager.dart';
import '../models/playlist_info.dart';

class PlaylistRepository extends ChangeNotifier {
  PlaylistRepository._();
  static final instance = PlaylistRepository._();

  List<PlaylistInfo> get playlists => _playlists;
  List<PlaylistInfo> _playlists = [];

  final service = LazyUserDataManager.instance;

  Future<void> init() async {
    _playlists = await service.getAllPlaylistInfos();
    notifyListeners();
  }

  Future<void> createPlaylist(PlaylistInfo info) async {
    try {
      _playlists.add(info);
      await service.addOrUpdatePlaylistInfo(info);
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  Future<void> deletePlaylist(String id) async {
    try {
      _playlists.removeWhere((e) => e.id == id);
      service.deletePlaylistInfo(id);
      service.deletePlaylist(id);
      notifyListeners();
    } catch (e) {
      return;
    }
  }
}
