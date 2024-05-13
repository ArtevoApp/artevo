import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:artevo_package/models/music_content.dart';

import '../../../services/cache/lazy_user_data_manager.dart';
import '../models/playlist.dart';
import '../widgets/create_playlist_dialog.dart';
import '../widgets/music_card.dart';
import '../repository/music_repository.dart';
import '../widgets/playlist_info_card.dart';

import '../../../common/config/color_schemes.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../localization/app_localizations_context.dart';
import '../../../screens/discover/discovery_screen_variables.dart';
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
    discoveryScreenTabIndex = 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: largePadding),
      child: RefreshIndicator(
        onRefresh: init,
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(child: searchBar(context)),
            SliverToBoxAdapter(child: playlistsPanel()),
            SliverToBoxAdapter(child: lastListenedMusics()),
          ],
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MusicSearchScreen())),
        child: InputDecorator(
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: lightColorScheme.tertiary.withOpacity(.15),
            prefixIcon: const Icon(Iconsax.search_normal),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(mediumPadding),
            ),
          ),
          child: Text(context.loc.search),
        ),
      ),
    );
  }

  Widget playlistsPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(context.loc.playlists, style: TextStyles.quote),
            const Spacer(),
            IconButton(
              onPressed: () => CreatePlaylistDialog.show(context)
                  .then((v) => v == true ? getPlaylists() : null),
              icon: const Icon(Iconsax.additem),
            )
          ],
        ),
        SizedBox(
          height: 200,
          child: ValueListenableBuilder(
              valueListenable: playlistInfos,
              builder: (context, value, child) {
                if (value.isNotEmpty) {
                  return GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: value.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: smallPadding,
                            mainAxisSpacing: smallPadding,
                            childAspectRatio: .24),
                    itemBuilder: (context, index) =>
                        PlaylistInfoCard(playlistInfo: value[index]),
                  );
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.loc.noPlaylistFound,
                          textAlign: TextAlign.center),
                      const SizedBox(height: defaultPadding),
                      ElevatedButton.icon(
                          onPressed: () => CreatePlaylistDialog.show(context)
                              .then((v) => v == true ? getPlaylists() : null),
                          icon: const Icon(Iconsax.additem),
                          label: Text(context.loc.create))
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget lastListenedMusics() {
    return ValueListenableBuilder(
        valueListenable: lastListenedMusicList,
        builder: (context, value, child) {
          if (value.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: largePadding),
                Text(context.loc.listenAgain, style: TextStyles.quote),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return MusicCard(music: value.elementAt(index));
                  },
                ),
                if (lastListenedMusicList.value.length > 4)
                  IconButton(
                    onPressed: showMoreOnPressed,
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(getAllLastListenedMusic.value
                            ? Iconsax.arrow_up_2
                            : Iconsax.arrow_down_1),
                      ],
                    ),
                  )
              ],
            );
          }
          return const SizedBox.shrink();
        });
  }
}
