import 'package:flutter/material.dart';

class MediaFileModel {
  String fileName;
  String url;
  ContentType contentType;
  int dayNumber;
  String description = "";
  double ratio = 0.0;
  Widget media;

  bool hasDescription() => description.isNotEmpty;
  MediaFileModel.fromJsonMap(MapEntry<String, dynamic> entry) {
    dynamic value = entry.value;
    //create a MediaFileModel with those data
    dayNumber = int.parse(entry.key);
    fileName = value['file'][0];
    description = value['desc'] ?? "";
    ratio = value['ratio'] != null ? double.parse(value['ratio']) : 0.0;

    if (fileName.endsWith("mp4") || fileName.endsWith("mov")) {
      contentType = ContentType.video;
    } else if (fileName.endsWith("jpg") ||
        fileName.endsWith("jpeg") ||
        fileName.endsWith("png") ||
        fileName.endsWith("gif")) {
      contentType = ContentType.image;
    } else {
      contentType = ContentType.unknown;
    }
  }
}

enum ContentType { video, image, unknown }
