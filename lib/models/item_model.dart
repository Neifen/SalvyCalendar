import 'package:flutter/foundation.dart';
import 'package:salvy_calendar/models/content_type.dart';

class ItemModel {
  String path;
  ContentType contentType;

  //for videos
  String? thumbnail;

  ItemModel({required this.path, required this.contentType, this.thumbnail});

  ItemModel.fromJson(Map<String, dynamic> map)
      : path = map['path'],
        contentType = ContentTypeUtil.fromString(map['contentType'] as String? ?? ""),
        thumbnail = map['thumbnail'];

  Map<String, dynamic> toJson() => {
        'path': path,
        'thumbnail': thumbnail,
        'contentType': describeEnum(contentType),
      };

  static List<ItemModel> fromJsonList(List<dynamic> json) {
    return json.map((m) => ItemModel.fromJson(m as Map<String, dynamic>)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<ItemModel> models) {
    return models.map((m) => m.toJson()).toList();
  }
}
