part of "painting_discover_view.dart";

mixin PaintingDiscoverMixin on ConsumerState<PaintingDiscoverView> {
  /// The search text of the search query.
  String searchText = "";

  /// The controller for pagination.
  final pagingController =
      PagingController<int, PaintingContent>(firstPageKey: 0);

  @override
  void initState() {
    pagingController
        .addPageRequestListener((pageKey) => fetchPaintings(pageKey));

    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    searchText;
    super.dispose();
  }

  Future<void> fetchPaintings(int pageKey) async {
    try {
      List<PaintingContent> newItems = [];

      // if user make a search, get paintings by search text
      if (searchText.isNotEmpty) {
        newItems =
            await PaintingRepository.getPaintingsBySearchText(searchText);
      }
      // else get paintings randomly
      else {
        newItems = await PaintingRepository.getPaintingsRandomly();
      }

      // if user make a search, max page 2 else max page 4.
      final maxPage = searchText.isNotEmpty ? 1 : 3;

      if (pageKey > maxPage) {
        pagingController.appendPage(newItems, null);
      } else {
        pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void onSearchStatusChanged(SearchStatus searchStatus) {
    if (searchStatus.isSearch) {
      // TODO: remove ref from here and
      // TODO: ConsumerStatefulWidget change to StatfulWidget from painting_discover_view.dart
      searchText = ref.watch(searchTextProvider);
      pagingController.refresh();
    } else if (searchStatus.isClear) {
      searchText = "";
      pagingController.refresh();
    } else {
      searchText = "";
    }
  }
}
