part of "paintings_discovery_screen.dart";

mixin PaintingsDiscoveryMixin on State<PaintingsDiscoveryScreen> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final maxPaintingCount = 24;
  final repository = PaintingDiscoveryRepository.instance;
  final paintingDiscoverViewTypeIsGrid = ValueNotifier<bool>(true);

  @override
  void initState() {
    repository.getPaintings(limit: maxPaintingCount);
    super.initState();
  }
}
