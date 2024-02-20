import 'package:artevo/services/hive/hive_content_data_service.dart';
import 'package:artevo_package/models/song.dart';
import 'package:artevo_package/services/song_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerRepository extends ChangeNotifier {
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  final _audioPlayer = AudioPlayer();

  Song _currentSong = HiveContentDataService().getSongData() ??
      Song(
          artist: "Song is not found!",
          name: "",
          url: "",
          albumImageUrl: "",
          ytMusicUrl: "",
          spotifyUrl: "",
          appleMusicUrl: "");

  AudioPlayer get player => _audioPlayer;

  String get getCurrentSongUrl => _currentSong.albumImageUrl;

  Song get getCurrentSong => _currentSong;

  bool get isPlaying => _audioPlayer.playing;

  AudioPlayerRepository() {
    _init();
  }

  void _init() async {
    await changeSong(_currentSong);

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  Future<void> changeSong(Song? newSong) async {
    if (newSong != null) {
      try {
        String? songUrl =
            await SongService().songDownloadUrlParser(newSong.url);

        if (songUrl != null && songUrl != "") {
          UriAudioSource source = AudioSource.uri(
            Uri.parse(songUrl.toString()),
            tag: MediaItem(
              id: "3521544",
              album: newSong.artist,
              title: newSong.name,
              artist: newSong.artist,
              artUri: Uri.parse(newSong.albumImageUrl),
              displayTitle: newSong.artist,
              displaySubtitle: newSong.name,
            ),
          );

          await _audioPlayer.setAudioSource(source);

          _currentSong = newSong;

          notifyListeners();
        }
      } catch (e) {
        Null;
      }
    }
  }

  void play() async {
    _audioPlayer.play();
    notifyListeners();
  }

  void pause() {
    _audioPlayer.pause();
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

enum ButtonState { paused, playing, loading }
