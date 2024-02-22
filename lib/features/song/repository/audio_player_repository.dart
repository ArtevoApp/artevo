import 'package:artevo/services/hive/hive_content_data_service.dart';
import 'package:artevo_package/modev2/music_content.dart';
import 'package:artevo_package/services/song_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerRepository extends ChangeNotifier {
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  final _audioPlayer = AudioPlayer();

  MusicContent _currentSong =
      HiveDailyContentDataService.instance.getSongData() ??
          MusicContent(
            title: '',
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

  String get getCurrentSongUrl => _currentSong.albumImageUrl;

  MusicContent get getCurrentSong => _currentSong;

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

  Future<void> changeSong(MusicContent? music) async {
    if (music != null) {
      try {
        String? songUrl =
            await SongService().songStreamUrlParser(music.musicSourceUrl);

        if (songUrl != null && songUrl != "") {
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

          await _audioPlayer.setAudioSource(source);

          _currentSong = music;

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
