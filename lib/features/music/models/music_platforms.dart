enum MusicPlatform { ytMusic, spotify, appleMusic }

extension MusicPlatformExtension on MusicPlatform {
  String _path() {
    switch (this) {
      case MusicPlatform.ytMusic:
        return "yt_music";
      case MusicPlatform.spotify:
        return "spotify";
      case MusicPlatform.appleMusic:
        return "apple_music";
    }
  }

  String get path => "assets/music_platforms/${_path()}.svg";
}
