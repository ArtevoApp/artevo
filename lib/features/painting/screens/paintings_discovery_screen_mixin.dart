part of "paintings_discovery_screen.dart";

mixin PaintingsDiscoveryMixin on State<PaintingsDiscoveryScreen> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final maxPaintingCount = 24;

  bool isLoading = false;

  final paintings = ValueNotifier<List<PaintingContent>>([]);

  @override
  void initState() {
    getPaintings();

    super.initState();
  }

  @override
  void dispose() {
    refreshIndicatorKey;
    maxPaintingCount;
    paintings.dispose();
    super.dispose();
  }

  Future<void> getPaintings({int? limit, bool? clearList = false}) async {
    try {
      isLoading = true;
      final newPaintings =
          await PaintingRepository.instance.getPaintingsRandomly(limit: limit);
      await Future.delayed(500.milliseconds);

      if (clearList!) {
        paintings.value = newPaintings;
      } else {
        paintings.value = [...paintings.value, ...newPaintings];
      }
    } catch (e) {
      return;
    } finally {
      isLoading = false;
    }
  }

  void moreButtonOnPressed() async {
    NavBarController.instance.discoverScrollController.jumpTo(0);
    await Future.delayed(500.milliseconds);
    refreshIndicatorKey.currentState!.show();
  }
}
