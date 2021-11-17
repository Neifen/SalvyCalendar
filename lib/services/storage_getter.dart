import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:salvy_calendar/models/media_file_model.dart';
import 'package:salvy_calendar/view/widgets/video_widget.dart';

class StorageGetter {
  static Map<int, MediaFileModel> _dayToFileMap = {};
  static String _baseUrl = "https://firebasestorage.googleapis.com";
  static String _moreUrl = "/v0/b/calendarr-260410.appspot.com/o/$_corps%2F";

  static final String _urlMediaSuffix = "?alt=media";
  static String? _corps;

  static init(String corps) {
    _corps = corps;

    if (_dayToFileMap.isEmpty) {
      _mapDaysFromFirebase();
    }
  }

  static Future<void> _mapDaysFromFirebase() async {
    _initiateFirebase();

    //first get the overview file
    Response response = await get(_getUri('calendar.json'));
    if (response.statusCode != HttpStatus.ok) {
      if (response.statusCode == HttpStatus.notFound) throw ("Either corps $_corps doesn't exist or there is no calendar.json defined");

      throw ("There was a network error (${response.statusCode})");
    }

    //then transform and parse the lines/ the numbers from the rest

    Map<String, dynamic> days = jsonDecode(utf8.decode(response.bodyBytes));

    for (MapEntry<String, dynamic> element in days.entries) {
      var file = MediaFileModel.fromJsonMap(element);

      for (var fileName in file.fileNames) {
        file.urls.add(_getUri(fileName));
      }

      _dayToFileMap[file.dayNumber] = file;
    }
    print("All calendar items are loaded, there is ${_dayToFileMap.length} days");
  }

  static Future<MediaFileModel> getContent(int day) async {
    print("Get Content for day $day");

    if (_dayToFileMap.isEmpty) {
      await _mapDaysFromFirebase();
    }

    if (!_dayToFileMap.containsKey(day)) {
      throw ("The day $day is not saved in the dayToFileMap with ${_dayToFileMap.length} values");
    }

    var dayFile = _dayToFileMap[day];

    if (dayFile!.media == null) {
      switch (dayFile.contentType) {
        case ContentType.video:
          dayFile.media = VideoWidget(dayFile);
          break;

        case ContentType.image:
          List<Widget> imageList = [];
          for (var url in dayFile.urls) {
            var data = await get(url);
            Image image = Image.memory(
              data.bodyBytes,
            );
            Completer<double> completer = new Completer<double>();

            image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener((info, _) {
              completer.complete(0.2);
            }));
            await completer.future;
            imageList.add(image);
          }

          dayFile.media = CarouselSlider(
            items: imageList,
            options: CarouselOptions(
              enlargeCenterPage: true,
              aspectRatio: 2.0,
            ),
          );
          break;
        case ContentType.unknown:
          throw ("The day $day doesn't have an image or video saved but a ${dayFile.contentType}");
      }
    }

    return dayFile;
  }

  static _getUri(String filename) {
    var uri = Uri.parse('$_baseUrl$_moreUrl$filename$_urlMediaSuffix');
    return uri;
  }

  static _initiateFirebase() {
    if (Firebase.apps.length == 0) {
      Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyAhChCiAoLRv_lPxv_pZSPcnNmtl0HvR-U",
              authDomain: "calendarr-260410.firebaseapp.com",
              databaseURL: "https://calendarr-260410.firebaseio.com",
              projectId: "calendarr-260410",
              storageBucket: "calendarr-260410.appspot.com",
              messagingSenderId: "1036752557927",
              appId: "1:1036752557927:web:882ae6d88c959af5a781c2",
              measurementId: "G-C5E1LBCGSX"));
    }
  }
}
