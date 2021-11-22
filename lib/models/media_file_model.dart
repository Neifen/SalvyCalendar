import 'package:flutter/material.dart';
import 'package:salvy_calendar/models/item_model.dart';

class MediaFileModel {
  List<ItemModel> items = [];
  int dayNumber;
  String description = "";
  Widget? media;

  bool hasDescription() => description.isNotEmpty;

  MediaFileModel({required this.dayNumber});
  MediaFileModel.fromJson(String id, Map<String, dynamic> map)
      : dayNumber = int.parse(id),
        description = map['des'] ?? "",
        items = ItemModel.fromJsonList(map['items'] as List<dynamic>);

  Map<String, dynamic> toJson() => {'des': description, 'items': ItemModel.toJsonList(items)};
}
