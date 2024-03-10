import 'package:artevo/common/helpers/functions.dart';
import 'package:artevo/features/music/controllers/music_controllers.dart';
import 'package:artevo/features/music/repository/audio_player_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

/// Play/Pause Button, Slider and Duration
class MusicPlayerControllers extends ConsumerWidget {
  const MusicPlayerControllers({super.key});

  @override
  Widget build(BuildContext context, ref) {
    AudioPlayerRepository player = ref.watch(audioPlayerRepositoryProvider);

    Duration? position =
        ref.watch(positionStreamProvider).value ?? Duration.zero;

    Duration? buffered =
        ref.watch(bufferedStreamProvider).value ?? Duration.zero;

    AsyncValue<Duration?> duration = ref.watch(durationStreamProvider);

    return Row(
      children: [
        playPauseButton(context, player),
        sliderWidget(context, duration, position, buffered, player),
      ],
    );
  }

  Widget playPauseButton(BuildContext _, AudioPlayerRepository player) {
    return IconButton(
      onPressed: () => player.isPlaying ? player.pause() : player.play(),
      icon: Icon(
        player.isPlaying ? Iconsax.pause : Iconsax.play,
        color: Theme.of(_).colorScheme.primary,
      ),
    );
  }

  Widget sliderWidget(BuildContext _, AsyncValue<Duration?> fDuration,
      Duration position, Duration buffered, AudioPlayerRepository player) {
    return Expanded(
      child: fDuration.when(
        data: (durationData) {
          Duration duration = durationData ?? Duration.zero;

          return Row(
            children: <Widget>[
              // * instant duration
              durationWidget(position),

              // * bar
              Expanded(
                child: SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 2,
                    activeTrackColor: Color(0xff035e4f),
                    secondaryActiveTrackColor: Colors.teal,
                    inactiveTrackColor: Color(0xffDCDBDC),
                    thumbColor: Color(0xff035e4f),
                    thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 5, disabledThumbRadius: 8),
                    overlayShape: RoundSliderThumbShape(
                        enabledThumbRadius: 7, disabledThumbRadius: 8),
                  ),
                  child: Slider(
                      value: position.inSeconds / duration.inSeconds,
                      secondaryTrackValue:
                          buffered.inSeconds / duration.inSeconds,
                      onChanged: (v) async {
                        player.pause();

                        await player.seek(Duration(
                            seconds: (v * duration.inSeconds).toInt()));
                      },
                      onChangeEnd: (v) => player.play()),
                ),
              ),

              // * total duration
              durationWidget(duration)
            ],
          );
        },
        error: (error, stackTrace) => const SizedBox(),
        loading: () => const LinearProgressIndicator(),
      ),
    );
  }

  SizedBox durationWidget(Duration duration) {
    return SizedBox(
      width: 30,
      child: Text(Functions.secondToMinute(duration),
          style: const TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }
}
