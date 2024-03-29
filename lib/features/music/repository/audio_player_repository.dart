import 'package:artevo/services/hive/hive_daily_content_data_service.dart';
import 'package:artevo_package/enums/content_type.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:artevo_package/services/music_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerRepository extends ChangeNotifier {
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  final _audioPlayer = AudioPlayer();

  MusicContent _currentSong =
      HiveDailyContentDataService.instance.getMusicData() ??
          MusicContent(
            contentType: ContentType.musicContent,
            title: 'Music is not found',
            creator: '',
            albumImageUrl: '',
            ytMusicUrl: '',
            langCode: 'en',
            editorNickname: "",
            editorUid: "",
            musicSourceUrl: "",
            appleMusicUrl: "",
            spotifyUrl: "",
          );

  AudioPlayer get player => _audioPlayer;

  MusicContent get getCurrentSong => _currentSong;

  bool get isPlaying => _audioPlayer.playing;

  AudioPlayerRepository() {
    _init();
  }

  void _init() async {
    // await changeSong(_currentSong);

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

  Future<void> changeSong(MusicContent? music) async {
    if (music == null) return;

    try {
      String? songUrl =
          await MusicService.streamUrlFromSourceUrl(music.musicSourceUrl);

      if (songUrl == null) return;

      UriAudioSource source = AudioSource.uri(
        Uri.parse(songUrl.toString()),
        tag: MediaItem(
          id: "3521544",
          title: music.title,
          artist: music.creator,
          artUri: Uri.parse(music.albumImageUrl),
          displayTitle: music.creator,
          displaySubtitle: music.title,
        ),
      );

      await _audioPlayer.pause();

      await _audioPlayer.setAudioSource(source);

      await seek(Duration.zero);

      await _audioPlayer.play();

      _currentSong = music;

      notifyListeners();
    } catch (e) {
      Null;
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
