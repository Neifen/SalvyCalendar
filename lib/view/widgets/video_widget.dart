import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:salvy_calendar/models/media_file_model.dart';

class VideoWidget extends StatefulWidget {
  final MediaFileModel dayFile;

  VideoWidget(this.dayFile);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoElement _video;

  @override
  void dispose() {
    _video.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _url = widget.dayFile.urls[0].toString();

    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(_url, (int viewId) {
      _video = VideoElement()
        ..id = 'videoPlayer${DateTime.now().millisecondsSinceEpoch}'
        // ..width = widget.width
        // ..height = widget.height
        ..src = _url
        ..autoplay = false
        ..controls = true
        ..disableRemotePlayback = true
        ..style.border = 'none';
      _video.attributes['controlsList'] = 'nodownload';

      return _video;
    });

    return AspectRatio(
      aspectRatio: widget.dayFile.ratio,
      child: Stack(children: [
        // VideoPlayer(_videoController),
        HtmlElementView(viewType: _url),
      ]),
    );
  }
}
