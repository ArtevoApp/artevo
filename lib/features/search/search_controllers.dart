import 'package:artevo/features/search/enum/search_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchStatusProvider =
    StateProvider.autoDispose<SearchStatus>((ref) => SearchStatus.idle);

final searchTextProvider = StateProvider.autoDispose<String>((ref) => "");
