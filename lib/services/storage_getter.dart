import 'dart:convert';
import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:salvy_calendar/models/media_file_model.dart';
import 'package:video_player/video_player.dart';

class StorageGetter {
  static Map<int, MediaFileModel> _dayToFileMap = Map();
  static String _baseUrl =
      "https://firebasestorage.googleapis.com/v0/b/calendarr-260410.appspot.com/o/$_corps%2F";
  static final String _urlMediaSuffix = "?alt=media";
  static String _corps;

  static init(String corps) {
    _corps = corps;

    if (_dayToFileMap.isEmpty) {
      _mapDaysFromFirebase();
    }
  }

  static Future<void> _mapDaysFromFirebase() async {
    _initiateFirebase();

    //first get the overview file
    String url = _getUrl("calendar.txt");

    Response response = await get(url);
    if (response.statusCode != HttpStatus.ok) {
      if (response.statusCode == HttpStatus.notFound)
        throw ("Either corps $_corps doesn't exist or there is no calendar.txt defined");

      throw ("There was a network error (${response.statusCode})");
    }

    //then transform and parse the lines/ the numbers from the rest
    List<String> days = LineSplitter().convert(response.body);
    for (String element in days) {
      var file = MediaFileModel.fromTextFile(element);

      file.url = _getUrl(file.fileName);

      _dayToFileMap[file.dayNumber] = file;
    }
  }

  static Future<Widget> getContent(int day) async {
    if (_dayToFileMap.isEmpty) {
      await _mapDaysFromFirebase();
    }

    if (!_dayToFileMap.containsKey(day)) {
      throw ("The day $day is not saved in the dayToFileMap with ${_dayToFileMap.length} values");
    }

    var dayFile = _dayToFileMap[day];

    if (dayFile.preSave == null) {
      List<Widget> column = [];
      switch (dayFile.contentType) {
        case ContentType.video:
          var videoController = VideoPlayerController.network(dayFile.url);
          await videoController.initialize();
          column.add(Chewie(
              controller: ChewieController(
                  videoPlayerController: videoController,
                  allowPlaybackSpeedChanging: false)));
          break;
        case ContentType.image:
          column.add(CachedNetworkImage(
            imageUrl: dayFile.url,
            placeholder: (context, url) => CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          ));
          break;
        case ContentType.unknown:
          throw ("The day $day doesn't have an image or video saved but a ${dayFile.contentType}");
      }
      if (dayFile.hasDescription()) {
        column.add(Text(dayFile.description));
        _dayToFileMap[day].preSave = Column(
          children: column,
        );
      } else {
        _dayToFileMap[day].preSave = column[0];
      }
    }
    return dayFile.preSave;
  }

  static String _getUrl(String child) {
    return _baseUrl + child + _urlMediaSuffix;
  }

  static _initiateFirebase() {
    if (fb.apps.length == 0) {
      fb.initializeApp(
          apiKey: "AIzaSyAhChCiAoLRv_lPxv_pZSPcnNmtl0HvR-U",
          authDomain: "calendarr-260410.firebaseapp.com",
          databaseURL: "https://calendarr-260410.firebaseio.com",
          projectId: "calendarr-260410",
          storageBucket: "calendarr-260410.appspot.com",
          messagingSenderId: "1036752557927",
          appId: "1:1036752557927:web:882ae6d88c959af5a781c2",
          measurementId: "G-C5E1LBCGSX");
    }
  }
}
