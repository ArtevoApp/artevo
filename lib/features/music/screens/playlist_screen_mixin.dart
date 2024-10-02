part of 'playlist_screen.dart';

mixin PlaylistScreenMixin<T extends StatefulWidget> on State<PlaylistScreen> {
  // playlist info
  late PlaylistInfo playlistInfo;

  // playlist info name controller
  final playlistNameController = TextEditingController();

  // focus node for playlist name edit.
  final focusNode = FocusNode();

  // playlist
  final playlist = ValueNotifier<List<MusicContent>>([]);

  // painting content for edit mode
  final paintingContent = ValueNotifier<PaintingContent?>(null);

  // edit mode
  final editMode = ValueNotifier<bool>(false);

  // flags to block spam when play all and add to queue buttons are pressed.
  bool playedAll = false;
  bool addedToQueue = false;

  @override
  void initState() {
    super.initState();
    playlistInfo = widget.playlistInfo;
    playlistNameController.text = playlistInfo.name;
    getPlaylist();
  }

  @override
  void dispose() {
    playlistNameController.dispose();
    focusNode.dispose();
    playlist.dispose();
    paintingContent.dispose();
    playedAll;
    addedToQueue;
    super.dispose();
  }

  Future<void> getPlaylist() async {
    await LazyUserDataManager.instance.getPlaylist(widget.playlistInfo.id).then(
        (value) => playlist.value = value
            .map(
                (e) => MusicContent.fromMap((e as Map).cast<String, dynamic>()))
            .toList());
  }

  Future<void> getPaintingContent() async {
    paintingContent.value = await PaintingRepository.instance
        .getPaintingsRandomly(limit: 1)
        .then((v) => v.first);
  }

  Future<void> addQueueButtonPressed() async {
    if (addedToQueue || !mounted || playlist.value.isEmpty) return;

    audioHandler
        .addQueueItems(playlist.value.map((e) => e.toMediaItem()).toList());

    addedToQueue = true;
  }

  Future<void> playAllButtonPressed() async {
    if (playedAll || !mounted || playlist.value.isEmpty) return;

    await audioHandler
        .updateQueue(playlist.value.map((e) => e.toMediaItem()).toList());

    audioHandler.play();

    playedAll = true;
  }

  Future<void> saveEdits() async {
    final service = LazyUserDataManager.instance;

    final newPlaylistInfo = PlaylistInfo(
      id: playlistInfo.id,
      name: playlistNameController.text,
      coverContentID: paintingContent.value?.id ?? playlistInfo.coverContentID,
      coverTitle: paintingContent.value?.title ?? playlistInfo.coverTitle,
      description: "",
      coverUrl: paintingContent.value?.imageUrl ?? playlistInfo.coverUrl,
      createdAt: playlistInfo.createdAt,
    );

    await service.addOrUpdatePlaylistInfo(newPlaylistInfo);

    service.updatePlaylist(playlistInfo.id, playlist.value);

    editMode.value = false;

    playlistInfo = newPlaylistInfo;

    setState(() {});
  }

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;

    final item = playlist.value.removeAt(oldIndex);

    playlist.value.insert(newIndex, item);
  }

  void deletePlaylistItem(int index) {
    playlist.value.removeAt(index);
    setState(() {});
  }
}
