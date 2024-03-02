library smooth_video_progress;

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:video_player/video_player.dart';

/// A widget that provides a method of building widgets using an interpolated
/// position value for [BetterPlayerController].
class CustomSmoothVideoProgress extends HookWidget {
  const CustomSmoothVideoProgress({
    Key? key,
    required this.controller,
    required this.builder,
    this.child,
  }) : super(key: key);

  /// The [BetterPlayerController] to build a progress widget for.
  final BetterPlayerController controller;

  /// The builder function.
  ///
  /// [progress] holds the interpolated current progress of the video. Use
  /// [duration] (the total duration of the video) to calculate a relative value
  /// for a slider for example for convenience.
  /// [child] holds the widget you passed into the constructor of this widget.
  /// Use that to optimize rebuilds.
  final Widget Function(BuildContext context, Duration progress,
      Duration duration, Widget? child) builder;

  /// An optional child that will be passed to the [builder] function and helps
  /// you optimize rebuilds.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final value = useValueListenable(controller.videoPlayerController!);
    final animationController = useAnimationController(
        duration: value.duration, keys: [value.duration]);

    final targetRelativePosition = value.duration == null
        ? 0.0
        : (value.position.inMilliseconds / value.duration!.inMilliseconds);

    final currentPosition = Duration(
        milliseconds: value.duration == null
            ? 0
            : (animationController.value * value.duration!.inMilliseconds)
                .round());

    final offset = value.position - currentPosition;

    useValueChanged(
      value.position,
      (_, __) {
        final correct = value.isPlaying &&
            offset.inMilliseconds > -500 &&
            offset.inMilliseconds < -50;
        final correction = const Duration(milliseconds: 500) - offset;
        final targetPos =
            correct ? animationController.value : targetRelativePosition;
        final duration =
            correct ? value.duration! + correction : value.duration;

        animationController.duration = duration;
        value.isPlaying
            ? animationController.forward(from: targetPos)
            : animationController.value = targetRelativePosition;
        return true;
      },
    );

    useValueChanged(
      value.isPlaying,
      (_, __) => value.isPlaying
          ? animationController.forward(from: targetRelativePosition)
          : animationController.stop(),
    );

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final millis = value.duration == null
            ? 0
            : animationController.value * value.duration!.inMilliseconds;
        return builder(
          context,
          Duration(milliseconds: millis.round()),
          value.duration!,
          child,
        );
      },
      child: child,
    );
  }
}
