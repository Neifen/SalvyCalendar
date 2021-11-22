import 'dart:async';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:salvy_calendar/models/item_model.dart';
import 'package:salvy_calendar/models/media_file_model.dart';
import 'package:salvy_calendar/services/days_service.dart';
import 'package:salvy_calendar/util/day_util.dart';
import 'package:screenshot/screenshot.dart';

class Thumbnail extends StatefulWidget {
  final ItemModel item;
  final String corp;
  final MediaFileModel model;

  Thumbnail(this.corp, this.model, this.item);

  @override
  _ThumbnailState createState() => _ThumbnailState();
}

class _ThumbnailState extends State<Thumbnail> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.thumbnail != null) {
      return Image.network(widget.item.thumbnail!);
    }
    //todo: try to create a thumbnail
    String url = widget.item.path;
    Completer<double> ratioCompleter = Completer();
    Future<double> ratio = ratioCompleter.future;
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(url, (int viewId) {
      var video = VideoElement()..crossOrigin = 'anonymous';

      video.onLoadedMetadata.listen((event) {
        if (!ratioCompleter.isCompleted) {
          video.currentTime = 1;
          var calc = video.videoWidth / video.videoHeight;
          ratioCompleter.complete(calc >= 1 ? calc : 1);
        }
      });

      video.onSeeking.listen((event) async {
        var canva = CanvasElement();
        canva
          ..height = video.videoHeight
          ..width = video.videoWidth;

        canva.context2D..drawImage(video, video.videoWidth, video.videoHeight);
        //var imageElement = ImageElement(src: canva.toDataUrl());
        //var data = Uri.parse(canva.toDataUrl()).data;
        //DaysService.addThumbnail(widget.corp, widget.model, widget.item, data?.contentAsBytes());
      });

      video.src = url;
      return video;
    });

    return FutureBuilder<double>(
        future: ratio,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return AspectRatio(
                aspectRatio: snapshot.data!,
                child: HtmlElementView(
                  viewType: url,
                ));
          }
          return AspectRatio(
              aspectRatio: 1,
              child: HtmlElementView(
                viewType: url,
              ));
        });
  }
}
