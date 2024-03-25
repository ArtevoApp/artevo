import 'package:artevo/features/search/enum/search_status.dart';

extension SearchStatusExtension on SearchStatus {
  bool get isIdle => this == SearchStatus.idle;
  bool get isSearch => this == SearchStatus.search;
  bool get isClear => this == SearchStatus.clear;
}
