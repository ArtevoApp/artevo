import 'package:artevo/features/music/repository/audio_player_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioPlayerRepositoryProvider =
    ChangeNotifierProvider<AudioPlayerRepository>((ref) {
  return AudioPlayerRepository();
});

final positionStreamProvider = StreamProvider.autoDispose<Duration?>((ref) {
  return ref.read(audioPlayerRepositoryProvider).player.createPositionStream(
      minPeriod: const Duration(seconds: 1),
      maxPeriod: const Duration(seconds: 1));
});

final bufferedStreamProvider = StreamProvider.autoDispose<Duration?>((ref) {
  return ref.read(audioPlayerRepositoryProvider).player.bufferedPositionStream;
});

final durationStreamProvider = StreamProvider.autoDispose<Duration?>((ref) {
  return ref.read(audioPlayerRepositoryProvider).player.durationStream;
});
