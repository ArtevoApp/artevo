import 'package:artevo_package/services/music_service.dart';
import 'package:artevo_package/models/music_content.dart';

import '../../../services/cache/lazy_user_data_manager.dart';
import '../../../services/database/local/music_local_data_manager.dart';

final class MusicRepository {
  MusicRepository._();

  static MusicRepository? _instance;

  static MusicRepository get instance {
    _instance ??= MusicRepository._();
    return _instance!;
  }

  final _localDB = MusicLocalDataManager.instance;

  Future<List<MusicContent>> search(String query) async {
    try {
      LazyUserDataManager.instance.addLastSearchedMusic(query.trim());
      return await MusicService.search(query.trim()) ?? [];
    } catch (e) {
      return [];
    }
  }

  Future<void> addToListenedMusicList(MusicContent music) async {
    try {
      await _localDB.addToLastListened(music.toMap());
    } catch (e) {
      return;
    }
  }

  Future<List<MusicContent>> getLastListenedMusics({int? limit}) async {
    try {
      final musicList = await _localDB.getLastListened(limit: limit);

      return musicList.map(MusicContent.fromMap).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> getLastSearchedMusics() async {
    return await LazyUserDataManager.instance.getLastSearchedMusics();
  }
}
