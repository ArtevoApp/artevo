import 'package:artevo/common/widgets/loader.dart';
import 'package:artevo/features/discover/controllers/search_controller.dart';
import 'package:artevo/features/discover/repository/discover_music_repository.dart';
import 'package:artevo/features/music/view/widgets/music_card.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiscoverMusicSegmentView extends ConsumerWidget {
  const DiscoverMusicSegmentView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    String? searchText = ref.watch(searchTextProvider);

    // TODO:
    if (searchText == null) return const SizedBox.shrink();

    return FutureBuilder<List<MusicContent>?>(
      future: DiscoverMusicRepository.search(searchText),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isEmpty) {
            return Text("data is empty");
          } else {
            return Column(
              children: List.generate(snapshot.data!.length,
                  (index) => MusicCard(musicContent: snapshot.data![index])),
            );
          }
        } else if (snapshot.data == null) {
          return Text("data is null");
        } else {
          return Loader();
        }
      },
    );
  }
}
