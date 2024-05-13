import 'package:artevo_package/models/music_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/constants/dimens.dart';
import '../../../localization/app_localizations_context.dart';
import '../repository/music_repository.dart';
import '../widgets/music_card.dart';

part 'music_search_screen_mixin.dart';

class MusicSearchScreen extends StatefulWidget {
  const MusicSearchScreen({super.key});

  @override
  State<MusicSearchScreen> createState() => _MusicSearchScreenState();
}

class _MusicSearchScreenState extends State<MusicSearchScreen>
    with MusicSearchScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: searchBarWidget(context),
        bottom: const PreferredSize(
          preferredSize: Size(largePadding, largePadding),
          child: Divider(),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: searchedMusicList,
          builder: (context, value, child) {
            if (value.isNotEmpty) {
              return searchedMusicListWidget(value);
            } else {
              return lastListenedMusicListWidget();
            }
          }),
    );
  }

  TextField searchBarWidget(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: searchTextController,
      inputFormatters: [LengthLimitingTextInputFormatter(40)],
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: context.loc.search,
        suffixIcon: CloseButton(onPressed: searchTextController.clear),
      ),
      onSubmitted: (v) => searchMusic(),
    );
  }

  ListView searchedMusicListWidget(List<MusicContent> value) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      itemCount: value.length,
      itemBuilder: (context, index) {
        return MusicCard(music: value[index]);
      },
    );
  }

  Widget lastListenedMusicListWidget() {
    return ValueListenableBuilder(
        valueListenable: lastSearchedMusicList,
        builder: (context, value, child) {
          if (value.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: largePadding),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                itemCount: value.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: Row(
                        children: [
                          const Icon(Iconsax.activity),
                          const SizedBox(width: defaultPadding),
                          Text(context.loc.searchHistory),
                        ],
                      ),
                    );
                  }

                  return ListTile(
                    dense: true,
                    title: Text(value[index - 1]),
                    trailing:
                        const Icon(Iconsax.arrow_right_3, size: xsmallIconSize),
                    onTap: () {
                      searchTextController.text = value[index - 1];
                      searchMusic();
                    },
                  );
                },
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
