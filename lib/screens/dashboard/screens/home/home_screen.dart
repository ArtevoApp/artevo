import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:artevo_package/models/daily_content.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:artevo_package/models/poetry_content.dart';
import '../../../../common/config/routes.dart';
import '../../../../common/constants/dimens.dart';
import '../../../../common/constants/text_styles.dart';
import '../../../../common/enums/errors.dart';
import '../../../../common/extensions/app_localizations_extension.dart';
import '../../../../common/extensions/error_extension.dart';
import '../../../../common/widgets/bookmarking_button.dart';
import '../../../../common/widgets/image_viewer.dart';
import '../../../../common/widgets/loader.dart';
import '../../../../features/music/service/audio_player_helper.dart';
import '../../../../localization/app_localizations_context.dart';
import '../../../../services/data_manager.dart';
import '../../../error/error_screen.dart';
import '../../layout/main_layout_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  final layoutController = MainLayoutController.instance;
  @override
  void initState() {
    scrollController.addListener(() => layoutController
        .autoUpdateNavBarView(scrollController.position.userScrollDirection));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: smallPadding),
        children: [
          buildTitle(),
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
                    musicCard(dailyContent.music),
                    const SizedBox(height: xLargePadding),
                    paintingWidget(dailyContent.painting),
                    const SizedBox(height: xLargePadding),
                    poetryWidget(poetry),
                    const SizedBox(height: xLargePadding),
                  ],
                );
              } else if (snapshot.hasError) {
                if (snapshot.error is IError) {
                  return ErrorScreen(
                    msg: (snapshot.error as IError).msg(context),
                  );
                }
                return ErrorScreen(msg: IError.errContentNotFound.msg(context));
              } else {
                return const Padding(
                  padding: EdgeInsets.only(top: hugePadding),
                  child: Center(child: Loader()),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildTitle() {
    final todayDate = DateFormat('EE dd', context.loc.langCode)
        .format(DateTime.now())
        .split(" ");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.loc.todayInArtevo, style: TextStyles.title),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: xsmallPadding,
              horizontal: mediumPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultPadding),
              border: Border.all(
                width: .1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            child: Column(
              children: [
                Text(todayDate.first, style: TextStyles.b2),
                Text(todayDate.last, style: TextStyles.h1)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget musicCard(MusicContent music) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultPadding),
      onTap: () => AudioPlayerHelper.addQueueAndPlay(music),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultPadding),
          border: Border.all(
            width: .1,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        padding: const EdgeInsets.all(smallPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Icon(
                Iconsax.play,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
              ),
            ),
            Expanded(
              child: Column(
                children: [Text(music.title), Text(music.creator)],
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
  }

  Widget paintingWidget(PaintingContent painting) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(smallPadding),
          onTap: () => Navigator.pushNamed(context, paintingDetailRoute),
          child: ImageViewer(url: painting.imageUrl, byDownloading: true),
        ),
        const SizedBox(height: defaultPadding),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: smallPadding,
          children: [
            Text(
              painting.title,
              style: TextStyles.b1,
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              minSize: xsmallImageSize,
              child: Text(context.loc.more, style: TextStyles.b1),
              onPressed: () =>
                  Navigator.pushNamed(context, paintingDetailRoute),
            ),
          ],
        ),
      ],
    );
  }

  Widget poetryWidget(PoetryContent poetry) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              const IconButton(onPressed: null, icon: Icon(null)),
              Expanded(
                child: Text(
                  poetry.title,
                  style: TextStyles.h1,
                  textAlign: TextAlign.center,
                ),
              ),
              BookmarkingButton(content: poetry)
            ],
          ),
          const SizedBox(height: largePadding),
          SelectableText(
            poetry.poem,
            style: TextStyles.b1,
          ),
          const SizedBox(height: largePadding),
          Text(
            poetry.creator,
            style: TextStyles.h2,
          ),
        ],
      ),
    );
  }
}
