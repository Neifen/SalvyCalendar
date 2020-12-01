import 'dart:html';

import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import 'play_pause_overlay.dart';

class VideoWidget extends StatelessWidget {
  final VideoPlayerController _videoController;
  VideoElement video;

  VideoWidget(this._videoController);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: Stack(children: [
        VideoPlayer(_videoController),
        PlayPauseOverlay(
          controller: _videoController,
        ),
        VideoProgressIndicator(
          _videoController,
          allowScrubbing: true,
        ),
      ]),
    );
  }
}
