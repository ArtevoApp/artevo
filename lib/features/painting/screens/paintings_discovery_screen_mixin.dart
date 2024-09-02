part of "paintings_discovery_screen.dart";

mixin PaintingsDiscoveryMixin on State<PaintingsDiscoveryScreen> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final maxPaintingCount = 24;

  final repository = PaintingDiscoveryRepository.instance;

  void moreButtonOnPressed() async {
    NavBarController.instance.discoverScrollController.jumpTo(0);
    await Future.delayed(500.milliseconds);
    refreshIndicatorKey.currentState!.show();
  }
}
