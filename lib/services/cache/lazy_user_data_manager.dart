import 'package:artevo_package/models/music_content.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/music/models/playlist_info.dart';

class LazyUserDataManager {
  LazyUserDataManager._();

  static LazyUserDataManager? _instance;

  static LazyUserDataManager get instance {
    _instance ??= LazyUserDataManager._();
    return _instance!;
  }

  // lazy user data box.
  static const _lazyUserDataBox = "lazyUserDataBox";
  // Playlist Information Box for playlist id, name, cover...
  static const _playlistInfoBox = "playlistInfoBox";
  // Playlist Box stores the playlist according to the playlist ID.
  static const _playlistBox = "playlistBox";

  static LazyBox<dynamic> lazUserDataBox = Hive.lazyBox(_lazyUserDataBox);
  static LazyBox<dynamic> playlistInfoBox = Hive.lazyBox(_playlistInfoBox);
  static LazyBox<dynamic> playlistBox = Hive.lazyBox(_playlistBox);

  Future<void> init() async {
    await Hive.openLazyBox(_lazyUserDataBox);
    await Hive.openLazyBox(_playlistInfoBox);
    await Hive.openLazyBox(_playlistBox);
  }

  // Lazy User Data Functions -------------------------------------------------

  Future<List<String>> getLastSearchedMusics() async {
    final lastSearchedMusics = await lazUserDataBox.get("lastSearchedMusics");
    if (lastSearchedMusics == null) return [];
    return lastSearchedMusics as List<String>;
  }

  Future<void> addLastSearchedMusic(String key) async {
    List<String> list = await getLastSearchedMusics();
    final indexOfKey = list.indexOf(key);
    if (indexOfKey != -1) list.removeAt(indexOfKey);
    list.insert(0, key);
    if (list.length > 20) list = list.sublist(0, 20);
    lazUserDataBox.put("lastSearchedMusics", list);
  }

  // Playlist Info Functions --------------------------------------------------

  /// Add a new playlist to the playlistInfoBox.
  /// If the playlist already exists, update it.
  Future<void> addOrUpdatePlaylistInfo(PlaylistInfo playlist) async =>
      await playlistInfoBox.put(playlist.id, playlist.toMap());

  /// Delete a playlist from the playlistInfoBox.
  Future<void> deletePlaylistInfo(String playlistId) async =>
      await playlistInfoBox.delete(playlistId);

  /// Get all playlist infos from the playlistInfoBox.
  Future<List<PlaylistInfo>> getAllPlaylistInfos() async {
    final List<PlaylistInfo> playlists = [];

    for (final id in playlistInfoBox.keys) {
      final infoData = await playlistInfoBox.get(id.toString()) as Map?;
      if (infoData != null) {
        playlists.add(PlaylistInfo.fromMap(infoData.cast<String, dynamic>()));
      }
    }

    return playlists;
  }

  // Playlist Functions -------------------------------------------------------

  /// Get
  Future<List<dynamic>> getPlaylist(String playlistId) async =>
      (await playlistBox.get(playlistId) as List?) ?? [];

  Future<void> addMusicToPlaylist(String playlistId, MusicContent music) async {
    playlistBox
        .put(playlistId, [...await getPlaylist(playlistId), music.toMap()]);
  }

  Future<void> removeMusicFromPlaylist(String playlistId, int index) async {
    final playlist = await getPlaylist(playlistId);

    if (playlist.isNotEmpty && index < playlist.length) {
      playlist.removeAt(index);
      updatePlaylist(playlistId, playlist);
    }
  }

  Future<void> updatePlaylist(String playlistId, List<dynamic> musics) async =>
      playlistBox.put(playlistId, musics.map((e) => e.toMap()).toList());

  Future<void> deletePlaylist(String playlistId) async =>
      playlistBox.delete(playlistId);

  // Other Functions ---------------------------------------------------------

  Future<void> clear() async {
    await playlistInfoBox.clear();
    await playlistBox.clear();
  }
}
