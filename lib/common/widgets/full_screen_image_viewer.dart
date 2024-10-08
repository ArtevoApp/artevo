import 'package:artevo_package/models/painting_content.dart';
import 'package:flutter/material.dart';
import '../../core/config/color_schemes.dart';
import '../constants/dimens.dart';
import 'bookmarking_button.dart';
import 'image_viewer.dart';

class FullScreenImageViewer extends StatefulWidget {
  const FullScreenImageViewer({
    super.key,
    required this.painting,
    this.minScale = 1.0,
    this.maxScale = 4.0,
    this.fullScreenDoubleTapZoomScale = 2.0,
  });
  final PaintingContent painting;
  final double minScale;
  final double maxScale;
  final double? fullScreenDoubleTapZoomScale;

  static void open({
    required BuildContext context,
    required PaintingContent painting,
    double minScale = 1.0,
    double maxScale = 4.0,
    double fullScreenDoubleTapZoomScale = 2.0,
  }) async {
    showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) => FullScreenImageViewer(
        painting: painting,
        minScale: minScale,
        maxScale: maxScale,
        fullScreenDoubleTapZoomScale: fullScreenDoubleTapZoomScale,
      ),
    );
  }

  @override
  State<FullScreenImageViewer> createState() => _ImageZoomFullscreenState();
}

class _ImageZoomFullscreenState extends State<FullScreenImageViewer>
    with SingleTickerProviderStateMixin {
  final TransformationController _transformationController =
      TransformationController();
  late AnimationController _animationController;
  late double closingTreshold = MediaQuery.of(context).size.height /
      5; //the higher you set the last value the earlier the full screen gets closed

  Animation<Matrix4>? _animation;
  double _opacity = 1;
  double _imagePosition = 0;
  Duration _animationDuration = Duration.zero;
  Duration _opacityDuration = Duration.zero;
  late double _currentScale = widget.minScale;
  TapDownDetails? _doubleTapDownDetails;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => _transformationController.value = _animation!.value);
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedOpacity(
            duration: _opacityDuration,
            opacity: _opacity,
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: _animationDuration,
          top: _imagePosition,
          bottom: -_imagePosition,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: InteractiveViewer(
              constrained: true,
              transformationController: _transformationController,
              minScale: widget.minScale,
              maxScale: widget.maxScale,
              onInteractionStart: _onInteractionStart,
              onInteractionUpdate: _onInteractionUpdate,
              onInteractionEnd: _onInteractionEnd,
              child: GestureDetector(
                // need to have both methods, otherwise the zoom will be triggered before the second tap releases the screen
                onDoubleTapDown: (details) => _doubleTapDownDetails = details,
                onDoubleTap: _zoomInOut,
                child: Hero(
                  tag: widget.painting.id ?? widget.painting.title,
                  child: ImageViewer(
                    url: widget.painting.imageUrl,
                    boxFit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
          child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Navigator.of(context).pop(),
              child: AnimatedOpacity(
                duration: _opacityDuration,
                opacity: _opacity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                          radius: smallIconSize,
                          child: CloseButton(color: lightColorScheme.surface),
                          backgroundColor: darkColorScheme.surface),
                      const SizedBox(height: defaultPadding),
                      BookmarkingButton.withBackground(widget.painting),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _zoomInOut() {
    final Offset tapPosition = _doubleTapDownDetails!.localPosition;
    final double zoomScale =
        widget.fullScreenDoubleTapZoomScale ?? widget.maxScale;

    final double x = -tapPosition.dx * (zoomScale - 1);
    final double y = -tapPosition.dy * (zoomScale - 1);

    final Matrix4 zoomedMatrix = Matrix4.identity()
      ..translate(x, y)
      ..scale(zoomScale);

    final Matrix4 widgetMatrix = _transformationController.value.isIdentity()
        ? zoomedMatrix
        : Matrix4.identity();

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: widgetMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );

    _animationController.forward(from: 0);
    _currentScale = _transformationController.value.isIdentity()
        ? zoomScale
        : widget.minScale;
  }

  void _onInteractionStart(ScaleStartDetails details) {
    _animationDuration = Duration.zero;
    _opacityDuration = Duration.zero;
  }

  void _onInteractionEnd(ScaleEndDetails details) async {
    _currentScale = _transformationController.value.getMaxScaleOnAxis();
    setState(() {
      _animationDuration = const Duration(milliseconds: 300);
    });
    if (_imagePosition > closingTreshold) {
      setState(() {
        _imagePosition = MediaQuery.of(context).size.height; // move image down
      });
      Navigator.of(context).pop();
    } else {
      setState(() {
        _imagePosition = 0;
        _opacity = 1;
        _opacityDuration = const Duration(milliseconds: 300);
      });
    }
  }

  void _onInteractionUpdate(ScaleUpdateDetails details) async {
    if (details.pointerCount == 1 && _currentScale <= 1.05) {
      setState(() {
        _imagePosition += details.focalPointDelta.dy;
        _opacity =
            (1 - (_imagePosition / closingTreshold)).clamp(0, 1).toDouble();
      });
    }
  }
}
