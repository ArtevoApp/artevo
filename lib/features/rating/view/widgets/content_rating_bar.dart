import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/paths.dart';
import 'package:artevo/common/helpers/my_clipper.dart';
import 'package:artevo/features/rating/view/widgets/content_rating_feedback_dialog.dart';
import 'package:flutter/material.dart';

// fix
// TODO: make this class modular.

class ContentRatingBar extends StatefulWidget {
  const ContentRatingBar({super.key});

  @override
  State<ContentRatingBar> createState() => _ContentRatingBarState();
}

class _ContentRatingBarState extends State<ContentRatingBar> {
  // rating bar item count
  int itemCount = 5;
  // bar min width =  (item radius * 2)
  double barMinWidth = 50;
  // barMaxWidh = (item radius * 2) * item count + [ spacing * (item count - 1)]
  //     or     = (item size width) * item count + [ spacing * (item count - 1)]
  double barMaxWidth = 282;

  /// position on horizontal axis (barMaxWidth / 2).
  ValueNotifier<double> dxNotifier = ValueNotifier(141);

  @override
  void dispose() {
    dxNotifier.dispose();
    super.dispose();
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    if (details.localPosition.dx >= barMinWidth) {
      dxNotifier.value = details.localPosition.dx;
    }
  }

  void onHorizontalDragEnd(DragEndDetails details) async {
    double rating = (dxNotifier.value + 4) / barMaxWidth * itemCount;
    if (rating <= 1) rating = 1.0;
    if (rating >= 5) rating = 5.0;

    await ContentRatingFeedBackDialog.show(
        context, double.parse(rating.toStringAsFixed(1)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ratingBarBackground(),
        GestureDetector(
            onHorizontalDragUpdate: onHorizontalDragUpdate,
            onHorizontalDragEnd: onHorizontalDragEnd,
            child: ValueListenableBuilder(
                valueListenable: dxNotifier,
                builder: (context, value, child) {
                  return ratingBarForeground();
                })),
      ],
    );
  }

  Widget ratingBarBackground() => Wrap(
      spacing: defaultPadding,
      children: List.generate(
          itemCount,
          (i) => const CircleAvatar(
              radius: xsmallImageSize,
              backgroundImage: AssetImage(vincentGreyPath))));

  Widget ratingBarForeground() => Container(
      // Don't delete this container.
      // If it is deleted, GestureDetector does not work properly.
      color: Colors.transparent,
      child: ClipRect(
          clipper: MyClipper(dxNotifier.value),
          child: Wrap(
              spacing: defaultPadding,
              children: List.generate(
                itemCount,
                (i) => const CircleAvatar(
                    radius: xsmallImageSize,
                    backgroundImage: AssetImage(vincentPath)),
              ))));
}
