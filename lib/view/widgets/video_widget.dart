import 'dart:async';
import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

class VideoWidget extends StatefulWidget {
  final String path;
  VideoWidget(this.path);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoElement? _video;

  @override
  void dispose() {
    if (_video != null) {
      _video!.pause();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _url = widget.path;
    Completer<double> ratioCompleter = Completer();

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
      _video!.style.width = '100%';
      _video!.style.height = '100%';

      _video!.attributes['controlsList'] = 'nodownload';
      _video!.onLoadedMetadata.listen((event) {
        var calc = _video!.videoWidth / _video!.videoHeight;
        if (!ratioCompleter.isCompleted) {
          ratioCompleter.complete(calc >= 1.3 ? calc : 1.3);
        }
      });
      return _video!;
    });

    return FutureBuilder<double>(
        future: ratioCompleter.future,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var d = snapshot.data!;
            return AspectRatio(
                aspectRatio: d,
                child: HtmlElementView(
                  viewType: _url,
                ));
          }
          return AspectRatio(
            aspectRatio: 1.3,
            child: Stack(children: [
              HtmlElementView(viewType: _url),
            ]),
          );
        });
  }
}
