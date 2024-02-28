import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/custom_divider.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/painting/views/painting_zoom_view.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/hive/hive_daily_content_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaintingDetailScreen extends ConsumerWidget {
  const PaintingDetailScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
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
            SliverPersistentHeader(
              pinned: true,
              delegate: PaintingDetailAppBar(
                  title: detail.title,
                  imageUrl: painting.imageUrl,
                  context: context),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: SizedBox(
                  width: columnWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(largePadding),
                    child: Column(
                      children: [
                        Text(detail.detail, style: TextStyles.body),
                        const CustomDivider(),
                        const SizedBox(height: hugePadding),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class PaintingDetailAppBar extends SliverPersistentHeaderDelegate {
  PaintingDetailAppBar(
      {required this.imageUrl, required this.title, required this.context});
  final String title;
  final String imageUrl;
  final BuildContext context;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: FractionalOffset(0.0, 0.4), //Alignment.center,
                end: FractionalOffset(0.0, 1),
                colors: [Colors.black, Colors.transparent],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: InkWell(
              onTap: () =>
                  PaintingZoomScreen.show(url: imageUrl, context: context),
              child: ImageViewer(url: imageUrl, height: maxExtent),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              contentPadding: const EdgeInsets.all(smallPadding),
              title: Text(title,
                  style: const TextStyle(fontSize: 22),
                  textAlign: TextAlign.center),
              leading: const BackButton(),
              trailing: const Icon(null),
            )),
      ],
    );
  }

  @override
  double get maxExtent => MediaQuery.of(context).size.height / 1.75;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
