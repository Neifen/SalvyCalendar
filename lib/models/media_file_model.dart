import 'package:flutter/material.dart';

class MediaFileModel {
  List<String> fileNames;
  List<String> urls = List<String>();
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
    fileNames = List.from(value['file']);
    description = value['des'] ?? "";
    ratio = value['ratio'] != null ? double.parse(value['ratio']) : 0.0;

    if (fileNames[0].endsWith("mp4") || fileNames[0].endsWith("mov")) {
      contentType = ContentType.video;
    } else if (fileNames[0].endsWith("jpg") ||
        fileNames[0].endsWith("jpeg") ||
        fileNames[0].endsWith("png") ||
        fileNames[0].endsWith("gif")) {
      contentType = ContentType.image;
    } else {
      contentType = ContentType.unknown;
    }
  }
}

enum ContentType { video, image, unknown }
