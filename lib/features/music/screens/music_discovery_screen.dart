import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../repository/listening_history_reposiory.dart';
import '../repository/playlist_repository.dart';
import '../widgets/create_playlist_dialog.dart';
import '../widgets/music_card.dart';
import '../widgets/playlist_info_card.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../core/localization/app_localizations_context.dart';
import '../widgets/playlist_info_vertical_card.dart';
import 'music_listening_history_screen.dart';
import 'music_search_screen.dart';

part 'music_discovery_screen_mixin.dart';

class MusicDiscoveryScreen extends StatefulWidget {
  const MusicDiscoveryScreen({super.key});

  @override
  State<MusicDiscoveryScreen> createState() => _MusicDiscoveryScreenState();
}

class _MusicDiscoveryScreenState extends State<MusicDiscoveryScreen>
    with MusicDiscoveryScreenMixin {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: initRepositories,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: mediumPadding),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          const SizedBox(height: defaultPadding),
          searchBar(context),
          const SizedBox(height: defaultPadding),
          artevoPlaylists(),
          const SizedBox(height: defaultPadding),
          playlistsPanel(),
          const SizedBox(height: defaultPadding),
          lastListenedMusics(),
          const SizedBox(height: xxLargePadding),
        ],
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallPadding),
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultPadding),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MusicSearchScreen())),
        child: Container(
          height: 38,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(defaultPadding),
            border: Border.all(
              width: .2,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: mediumPadding,
            vertical: smallPadding,
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.search_normal,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: defaultPadding),
              Text(
                context.loc.search,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget artevoPlaylists() {
    return ListenableBuilder(
      listenable: playlistRepository,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.loc.artevoPlaylists, style: TextStyles.h1),
            const SizedBox(height: defaultPadding),
            SizedBox(
              height: 160,
              child: ListView.separated(
                itemCount: playlistRepository.playlists.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, i) => const SizedBox(width: 8),
                itemBuilder: (_, i) => PlaylistVerticalCard(
                    playlistInfo: playlistRepository.playlists[i]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget playlistsPanel() {
    return ListenableBuilder(
      listenable: playlistRepository,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.loc.yourLibrary, style: TextStyles.h1),
                IconButton(
                  onPressed: () => CreatePlaylistDialog.show(context),
                  icon: const Icon(Iconsax.additem),
                  color: Theme.of(context).colorScheme.primary,
                )
              ],
            ),
            SizedBox(
              height: 200,
              child: Builder(builder: (context) {
                if (playlistRepository.playlists.isNotEmpty) {
                  return GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: playlistRepository.playlists.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: smallPadding,
                      mainAxisSpacing: smallPadding,
                      childAspectRatio: .28,
                    ),
                    itemBuilder: (context, i) => PlaylistInfoCard(
                        playlistInfo: playlistRepository.playlists[i]),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.loc.noPlaylistFound,
                            textAlign: TextAlign.center),
                        const SizedBox(height: defaultPadding),
                        ElevatedButton.icon(
                            onPressed: () => CreatePlaylistDialog.show(context),
                            icon: const Icon(Iconsax.additem),
                            label: Text(context.loc.create))
                      ],
                    ),
                  );
                }
              }),
            ),
          ],
        );
      },
    );
  }

  Widget lastListenedMusics() {
    return ListenableBuilder(
      listenable: listeningHistoryReposiory,
      builder: (context, child) {
        final listeningHistory =
            listeningHistoryReposiory.listeningHistory.take(5).toList();
        if (listeningHistory.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.loc.listenAgain, style: TextStyles.h1),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(context.loc.history),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MusicHistoryScreen(),
                      ),
                    ),
                  )
                ],
              ),
              ...List.generate(
                listeningHistory.length,
                (i) => MusicCard(music: listeningHistory[i]),
              )
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
