part of "music_discovery_screen.dart";

mixin MusicDiscoveryScreenMixin on State<MusicDiscoveryScreen> {
  final playlistInfos = ValueNotifier<List<PlaylistInfo>>([]);

  final getAllLastListenedMusic = ValueNotifier<bool>(false);

  final lastListenedMusicList = ValueNotifier<List<MusicContent>>([]);

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    getAllLastListenedMusic.dispose();
    lastListenedMusicList.dispose();
    super.dispose();
  }

  Future<void> init() async {
    getPlaylists();
    getLastListenedMusic();
  }

  void getPlaylists() async {
    final result = await LazyUserDataManager.instance.getAllPlaylistInfos();

    if (result.isNotEmpty) playlistInfos.value = result;
  }

  void getLastListenedMusic({bool? getAll}) async {
    final result = await MusicRepository.instance
        .getLastListenedMusics(limit: getAll == true ? 30 : 5);

    if (result.isNotEmpty) {
      lastListenedMusicList.value = result;
    }
  }

  void showMoreOnPressed() {
    if (!getAllLastListenedMusic.value) {
      getLastListenedMusic(getAll: true);
    } else {
      getLastListenedMusic();
    }
    getAllLastListenedMusic.value = !getAllLastListenedMusic.value;
  }
}
