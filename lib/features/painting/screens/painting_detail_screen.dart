import '../../../common/config/color_schemes.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/widgets/bookmarking_button.dart';
import '../../../common/widgets/custom_divider.dart';
import '../../../common/widgets/image_viewer.dart';
import '../widgets/painting_zoom_dialog.dart';
import '../../../localization/app_localizations_context.dart';
import '../../../services/cache/daily_content_data_manager.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:artevo_package/models/painting_detail_content.dart';
import 'package:flutter/material.dart';

class PaintingDetailScreen extends StatelessWidget {
  const PaintingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final hive = DailyContentDataManager.instance;

    final painting = hive.getPaintingContentData();

    final detail = hive.getPaintingDetail(context.loc.langCode);

    if (painting == null || detail == null) {
      return Scaffold(
        appBar: AppBar(title: Text(context.loc.back), centerTitle: false),
        body: Center(child: Text(context.loc.contentIsNotFound)),
      );
    } else {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            appBar(detail.title, painting, height),
            body(detail),
          ],
        ),
      );
    }
  }

  Widget appBar(String title, PaintingContent painting, double height) =>
      SliverPersistentHeader(
          pinned: true,
          delegate: PaintingDetailAppBar(
              title: title, painting: painting, screenHeight: height));

  Widget body(PaintingDetailContent detail) => SliverToBoxAdapter(
        child: Center(
          child: SizedBox(
            width: columnWidth,
            child: Padding(
              padding: const EdgeInsets.all(largePadding),
              child: Column(
                children: [
                  Text(
                    detail.detail,
                  ),
                  const SizedBox(height: largePadding),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text('@${detail.creator}  ')),
                  const CustomDivider(),
                  const SizedBox(height: hugePadding),
                ],
              ),
            ),
          ),
        ),
      );
}

class PaintingDetailAppBar extends SliverPersistentHeaderDelegate {
  PaintingDetailAppBar(
      {required this.painting,
      required this.title,
      required this.screenHeight});

  /// The Title of the AppBar.
  final String title;

  /// The painting content
  final PaintingContent painting;

  /// Screen height to calculate the maximum height ([maxExtent]) of the AppBar.
  final double screenHeight;

  /// Horizontal padding to center the AppBar Title.
  /// We need the [BackButton] to its left and a space equal to its padding.
  /// [BackButton] is 40px (radius is 20) + BackButton's left padding.
  final horizontalPadding = hugeIconSize + defaultPadding;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final topPadding = MediaQuery.of(context).padding.top + 16;
    return Stack(fit: StackFit.expand, children: [
      appBarBackground(context),
      appBarBackButton(topPadding),
      appBarBookmarkingButton(topPadding),
      appBarTitle(topPadding)
    ]);
  }

  Widget appBarBackground(BuildContext _) => Container(
      color: Theme.of(_).scaffoldBackgroundColor,
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: FractionalOffset(0.0, 0.5), //Alignment.center,
            end: FractionalOffset(0.0, 1),
            colors: [Colors.black, Colors.transparent],
          ).createShader(bounds);
        },
        child: InkWell(
          onTap: () => PaintingZoomDialog.show(_, painting),
          child: ImageViewer(
              url: painting.imageUrl, boxFit: BoxFit.cover, height: maxExtent),
        ),
      ));

  Widget appBarBackButton(double topPadding) => Positioned(
      top: topPadding,
      left: defaultPadding,
      child: CircleAvatar(
          radius: smallIconSize,
          child: const BackButton(color: Colors.white),
          backgroundColor: darkColorScheme.background));

  Widget appBarBookmarkingButton(double topPadding) => Positioned(
        top: topPadding,
        right: defaultPadding,
        child: BookmarkingButton.withBackground(painting),
      );

  Padding appBarTitle(double topPadding) => Padding(
      padding: EdgeInsets.only(
          top: topPadding,
          bottom: 28,
          left: horizontalPadding,
          right: horizontalPadding),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(title,
              style: TextStyles.title, textAlign: TextAlign.center)));

  @override
  double get maxExtent => screenHeight / 2.25;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
