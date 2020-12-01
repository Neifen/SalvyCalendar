import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:salvy_calendar/models/media_file_model.dart';

class VideoWidget extends StatelessWidget {
  final MediaFileModel dayFile;

  VideoWidget(this.dayFile);

  @override
  Widget build(BuildContext context) {
    VideoElement video;

    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(dayFile.url, (int viewId) {
      video = VideoElement()
        ..id = 'videoPlayer${DateTime.now().millisecondsSinceEpoch}'
        // ..width = widget.width
        // ..height = widget.height
        ..src = dayFile.url
        ..autoplay = false
        ..controls = true
        ..disableRemotePlayback = true
        ..style.border = 'none';
      video.attributes['controlsList'] = 'nodownload';

      return video;
    });

    return AspectRatio(
      aspectRatio: dayFile.ratio,
      child: Stack(children: [
        // VideoPlayer(_videoController),
        HtmlElementView(viewType: dayFile.url),
      ]),
    );
  }
}
