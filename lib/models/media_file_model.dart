import 'package:flutter/widgets.dart';

class MediaFileModel {

  String fileName;
  String url;
  ContentType contentType;
  int dayNumber;
  Widget preSave;

  MediaFileModel(this.dayNumber, this.fileName){
    if(this.fileName.endsWith("mp4")){
      contentType = ContentType.video;
    }
    else if(this.fileName.endsWith("jpg") || this.fileName.endsWith("jpeg") || this.fileName.endsWith("png") || this.fileName.endsWith("gif")){
      contentType = ContentType.image;
    }
    else{
      contentType = ContentType.unknown;
    }
  }



}

enum ContentType{
  video,
  image,
  unknown
}