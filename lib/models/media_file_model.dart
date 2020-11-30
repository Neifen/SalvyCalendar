import 'package:flutter/material.dart';

class MediaFileModel {
  String fileName;
  String url;
  ContentType contentType;
  int dayNumber;
  String description = "";
  Widget media;

  bool hasDescription() => description.isNotEmpty;
  MediaFileModel.fromTextFile(String line) {
    var split = line.split(":");

    //create a MediaFileModel with those data
    dayNumber = int.parse(split[0]);
    fileName = split[1];
    description = split.length > 2 ? split[2] : "";

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
