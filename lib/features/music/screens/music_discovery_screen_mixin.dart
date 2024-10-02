part of "music_discovery_screen.dart";

mixin MusicDiscoveryScreenMixin on State<MusicDiscoveryScreen> {
  final playlistRepository = PlaylistRepository.instance;
  final listeningHistoryReposiory = ListeningHistoryReposiory.instance;

  @override
  void initState() {
    initRepositories();
    super.initState();
  }

  Future<void> initRepositories() async {
    await playlistRepository.init();
    await listeningHistoryReposiory.init();
  }
}
