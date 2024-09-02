import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:artevo_package/models/daily_content.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:artevo_package/models/poetry_content.dart';

import '../../common/config/routes.dart';
import '../../common/constants/dimens.dart';
import '../../common/constants/text_styles.dart';
import '../../common/enums/errors.dart';
import '../../common/extensions/app_localizations_extension.dart';
import '../../common/extensions/error_extension.dart';
import '../../common/widgets/bookmarking_button.dart';
import '../../common/widgets/custom_divider.dart';
import '../../common/widgets/image_viewer.dart';
import '../../common/widgets/loader.dart';
import '../../features/music/service/audio_player_helper.dart';
import '../../features/rating/controllers/content_rating_controllers.dart';
import '../../features/rating/view/widgets/content_rating_bar.dart';
import '../../localization/app_localizations_context.dart';
import '../../services/data_manager.dart';
import '../_main/nav_bar_controller.dart';
import '../error/error_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: NavBarController.instance.homeScrollController,
      padding: const EdgeInsets.symmetric(horizontal: smallPadding),
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + defaultPadding),
        title(context),
        const SizedBox(height: xLargePadding),
        FutureBuilder<Object>(
          future: DataManager.instance.checkDailyContentData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final dailyContent = snapshot.data! as DailyContent;

              final poetry = context.loc.isTr
                  ? dailyContent.trPoetry
                  : dailyContent.enPoetry;

              return Column(
                children: [
                  musicCard(context, dailyContent.music),
                  const SizedBox(height: xLargePadding),
                  paintingWidget(context, dailyContent.painting),
                  const SizedBox(height: xLargePadding),
                  poetryWidget(context, poetry),
                  contentRatingWidget(context),
                  const SizedBox(height: dialogWidth),
                ],
              );
            } else if (snapshot.hasError) {
              if (snapshot.error is IError) {
                return ErrorScreen(
                    msg: (snapshot.error as IError).msg(context));
              }
              return ErrorScreen(msg: IError.errContentNotFound.msg(context));
            } else {
              return const Padding(
                  padding: EdgeInsets.only(top: hugePadding),
                  child: Center(child: Loader()));
            }
          },
        )
      ],
    ).animate().fade(duration: const Duration(milliseconds: 500));
  }

  Widget title(BuildContext context) {
    final today =
        DateFormat('EE dd', context.loc.langCode).format(DateTime.now());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: mediumPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            child: Text(context.loc.todayInArtevo, style: TextStyles.pageTitle),
          )),
          Container(
            height: xxLargePadding,
            width: xxLargePadding,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.07),
              borderRadius: BorderRadius.circular(defaultPadding),
            ),
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Text(today.split(' ').first,
                    style: const TextStyle(fontSize: 10)),
                Text(today.split(' ').last,
                    style: const TextStyle(fontSize: 18))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget musicCard(BuildContext context, MusicContent music) {
    return Card(
      elevation: .5,
      child: Consumer(builder: (context, ref, ch) {
        return InkWell(
          onTap: () => AudioPlayerHelper.addQueueAndPlay(music),
          child: Padding(
            padding: const EdgeInsets.all(smallPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Iconsax.play,
                      color: Theme.of(context).colorScheme.primary),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(music.title,
                          style: TextStyles.body, textAlign: TextAlign.center),
                      Text(music.creator, textAlign: TextAlign.center)
                    ],
                  ),
                ),
                ImageViewer(
                  width: smallImageSize,
                  height: smallImageSize,
                  url: music.thumbnailUrl,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget paintingWidget(BuildContext context, PaintingContent painting) {
    return Column(
      children: [
        InkWell(
            onTap: () => Navigator.pushNamed(context, paintingDetailRoute),
            child: ImageViewer(url: painting.imageUrl, byDownloading: true)),
        const SizedBox(height: defaultPadding),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: smallPadding,
          children: [
            Text(painting.title,
                style: TextStyles.bodyv2, textAlign: TextAlign.center),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              minSize: xsmallImageSize,
              child: Text(context.loc.more, style: TextStyles.bodyv2),
              onPressed: () =>
                  Navigator.pushNamed(context, paintingDetailRoute),
            ),
          ],
        ),
      ],
    );
  }

  Widget poetryWidget(BuildContext context, PoetryContent poetry) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const IconButton(onPressed: null, icon: Icon(null)),
              Expanded(
                  child: Text(poetry.title,
                      style: TextStyles.title, textAlign: TextAlign.center)),
              BookmarkingButton(content: poetry)
            ],
          ),
          const SizedBox(height: largePadding),
          SelectableText(poetry.poem, style: TextStyles.body),
          const SizedBox(height: largePadding),
          Text(poetry.creator, style: TextStyles.body),
        ],
      ),
    );
  }

  Widget contentRatingWidget(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        if (!ref.watch(showContentRatingProvider)) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: largePadding),
              child: CustomDivider(),
            ),
            Text(context.loc.pollQuestion, style: TextStyles.bodyv2),
            const SizedBox(height: xLargePadding),
            const ContentRatingBar(),
          ],
        );
      },
    );
  }
}
