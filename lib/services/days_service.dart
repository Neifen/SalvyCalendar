import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:salvy_calendar/data/repo/day_repo.dart';
import 'package:salvy_calendar/data/repo/photo_repo.dart';
import 'package:salvy_calendar/models/content_type.dart';
import 'package:salvy_calendar/models/item_model.dart';
import 'package:salvy_calendar/models/media_file_model.dart';
import 'package:salvy_calendar/view/widgets/video_widget.dart';

class DaysService {
  static Map<int, MediaFileModel> _dayToFileMap = {};

  static init(String corps) async {
    if (_dayToFileMap.isEmpty) {
      _dayToFileMap = await DayRepo().getAll(corps);
    }
  }

  static Future<MediaFileModel> getContent(int day) async {
    print("Get Content for day $day");

    if (!_dayToFileMap.containsKey(day)) {
      throw ("The day $day is not saved in the dayToFileMap with ${_dayToFileMap.length} values");
    }

    var dayFile = _dayToFileMap[day];

    if (dayFile!.media == null) {
      List<Widget> itemList = [];
      for (var item in dayFile.items) {
        switch (item.contentType) {
          case ContentType.video:
            itemList.add(VideoWidget(item.path));
            break;
          case ContentType.image:
            var data = await get(Uri.parse(item.path));
            Image image = Image.memory(
              data.bodyBytes,
            );
            Completer completer = new Completer();

            image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener((info, _) {
              completer.complete();
            }));
            await completer.future;
            itemList.add(image);
            break;
          case ContentType.unknown:
            throw ("The day $day doesn't have an image or video saved but a ${dayFile.items.first.contentType}");
        }
      }
      if (itemList.length == 1) {
        dayFile.media = itemList.first;
      } else {
        dayFile.media = CarouselSlider(
          items: itemList,
          options: CarouselOptions(
            enlargeCenterPage: true,
            aspectRatio: 2.0,
          ),
        );
      }
    }

    return dayFile;
  }

  static deleteItemFromDay(String corp, MediaFileModel model, ItemModel item) async {
    await PhotoRepo.removePhoto(item.path);
    model.items.remove(item);
    await DayRepo().save(corp, model);
  }

  static addItemToDay(String corp, MediaFileModel model, PlatformFile file) async {
    var uploadPath = await PhotoRepo.uploadPhoto(corp, file);
    var newItem = ItemModel(path: uploadPath, contentType: ContentTypeUtil.getContentType(file.name));
    model.items.add(newItem);

    await DayRepo().save(corp, model);
  }

  static addThumbnail(String corp, MediaFileModel model, ItemModel item, Uint8List? capture) async {
    if (capture == null) {
      throw StateError('capture cant be empty when uploading a thumbnail');
    }
    await PhotoRepo.uploadCapture(corp, capture);
  }

  static void editDescription(String corp, int day, MediaFileModel? mediaFile, String text) {
    mediaFile ?? MediaFileModel(dayNumber: day);

    mediaFile!.description = text;
    DayRepo().save(corp, mediaFile);
  }
}
