import 'package:artevo_package/models/painting_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'painting_repository.dart';

class PaintingDiscoveryRepository extends ChangeNotifier {
  PaintingDiscoveryRepository._();

  static final instance = PaintingDiscoveryRepository._();

  List<PaintingContent> _paintings = [];

  List<PaintingContent> get paintings => _paintings;

  Future<void> getPaintings({int? limit, bool? clearList = false}) async {
    try {
      final newPaintings = await PaintingRepository.instance
          .getPaintingsRandomly(limit: limit ?? 24);
      await Future.delayed(500.milliseconds);

      if (clearList!) {
        _paintings = newPaintings;
      } else {
        _paintings = [...paintings, ...newPaintings];
      }
    } catch (e) {
      return;
    }
    notifyListeners();
  }
}
