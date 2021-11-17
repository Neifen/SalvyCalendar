import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayPauseOverlay extends StatefulWidget {
  final VideoPlayerController controller;

  const PlayPauseOverlay({Key? key, required this.controller}) : super(key: key);

  @override
  _PlayPauseOverlayState createState() => _PlayPauseOverlayState();
}

class _PlayPauseOverlayState extends State<PlayPauseOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
            duration: Duration(milliseconds: 50),
            reverseDuration: Duration(milliseconds: 200),
            child: widget.controller.value.isPlaying
                ? SizedBox.shrink()
                : Container(
                    color: Colors.black26,
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 100.0,
                      ),
                    ),
                  )),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.value.isPlaying ? widget.controller.pause() : widget.controller.play();
            });
          },
        )
      ],
    );
  }
}
