import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/custom_divider.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/painting/views/painting_zoom_view.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/hive/hive_daily_content_data_service.dart';
import 'package:artevo_package/modev2/painting_detail_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaintingDetailScreen extends ConsumerWidget {
  const PaintingDetailScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final height = MediaQuery.of(context).size.height;

    final hive = HiveDailyContentDataService.instance;

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
            appBar(detail.title, painting.imageUrl, height),
            body(detail),
          ],
        ),
      );
    }
  }

  Widget appBar(String title, String imageUrl, double height) =>
      SliverPersistentHeader(
          pinned: true,
          delegate: PaintingDetailAppBar(
              title: title, imageUrl: imageUrl, screenHeight: height));

  Widget body(PaintingDetailContent detail) => SliverToBoxAdapter(
        child: Center(
          child: SizedBox(
            width: columnWidth,
            child: Padding(
              padding: const EdgeInsets.all(largePadding),
              child: Column(
                children: [
                  Text(detail.detail, style: TextStyles.body),
                  Align(
                    alignment: Alignment.centerRight,
                    child:
                        Text('— ${detail.creator}', style: TextStyles.bodyv3),
                  ),
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
      {required this.imageUrl,
      required this.title,
      required this.screenHeight});

  /// The Title of the AppBar.
  final String title;

  /// The image url of the AppBar.
  final String imageUrl;

  /// Screen height to calculate the maximum height ([maxExtent]) of the AppBar.
  final double screenHeight;

  /// Horizontal padding to center the AppBar Title.
  /// We need the [BackButton] to its left and a space equal to its padding.
  /// [BackButton] is 40px (radius is 20) + BackButton's left padding.
  final horizontalPadding = hugeIconSize + defaultPadding;

  @override
  Widget build(BuildContext _, double shrinkOffset, bool overlapsContent) {
    final topPadding = MediaQuery.of(_).padding.top + 16;
    return Stack(fit: StackFit.expand, children: [
      appBarBackground(_),
      appBarBackButton(topPadding),
      appBarTitle(topPadding)
    ]);
  }

  Widget appBarBackground(_) => Container(
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
              onTap: () => PaintingZoomScreen.show(url: imageUrl, context: _),
              child: ImageViewer(url: imageUrl, height: maxExtent))));

  Widget appBarBackButton(double topPadding) => Positioned(
      top: topPadding,
      left: defaultPadding,
      child: CircleAvatar(
          radius: smallIconSize,
          child: BackButton(color: Colors.white),
          backgroundColor: Colors.grey.shade900.withOpacity(0.7)));

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
