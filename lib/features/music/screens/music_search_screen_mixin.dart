part of 'music_search_screen.dart';

mixin MusicSearchScreenMixin on State<MusicSearchScreen> {
  final focusNode = FocusNode();
  final searchTextController = TextEditingController();
  final searchedMusicList = ValueNotifier<List<MusicContent>>([]);
  final lastSearchedMusicList = ValueNotifier<List<String>>([]);

  @override
  void initState() {
    getLastSearchedMusics();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    searchedMusicList.dispose();
    lastSearchedMusicList.dispose();
    super.dispose();
  }

  void searchMusic() async {
    if (searchTextController.text.isNotEmpty) {
      searchedMusicList.value =
          await MusicRepository.instance.search(searchTextController.text);
    }
  }

  void getLastSearchedMusics() async {
    lastSearchedMusicList.value =
        await MusicRepository.instance.getLastSearchedMusics();
  }
}
