import 'package:flutter/widgets.dart';

class MediaFileModel {
  String fileName;
  Uri url;
  String contentType;
  int dayNumber;
  Widget preSave;

  MediaFileModel(this.dayNumber, this.fileName);

}
