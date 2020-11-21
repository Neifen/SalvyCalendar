import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:salvy_calendar/models/media_file_model.dart';

class StorageGetter {
  static Map<int, MediaFileModel> _dayToFileMap = Map();
  static fb.StorageReference _baseRef =
      fb.app().storage().refFromURL("gs://calendarr-260410.appspot.com/Bern");


  static _mapDaysFromFirebase() async {
   _initiateFirebase();

   //first get the overview file
    Uri url = await _getUrl("calendar.txt");
    var response = await get(url);

    //then transform and parse the lines/ the numbers from the rest
    List<String> days = LineSplitter().convert(response.body);
    days.forEach((element) async {
      var split = element.split(":");

      //create a MediaFileModel with those data
      var dayNr = int.parse(split[0]);
      var file = MediaFileModel(dayNr, split[1]);

      file.url = await _getUrl(file.fileName);
      var fileMeta = await _baseRef.child(file.fileName).getMetadata();
      file.contentType = fileMeta.contentType;

      _dayToFileMap[dayNr] = file;
    });
  }

  static Future<Widget> getContent(int day) async {
    if (_dayToFileMap.isEmpty) {
      _mapDaysFromFirebase();
    }
    if (_dayToFileMap.containsKey(day)) {
      var dayFile = _dayToFileMap[day];
      if (dayFile.contentType.startsWith("image")) {
        return Image.network(dayFile.url.toString());
      } else if (dayFile.contentType.startsWith("video")) {
        var videoController = VideoPlayerController.network(
            dayFile.url.toString());
        await videoController.initialize();
        return Chewie(controller: ChewieController(
            videoPlayerController: videoController));
      }
    }
    return CircularProgressIndicator();
  }


  static Future<Uri> _getUrl(String child) {
    return _baseRef.child(child).getDownloadURL();
  }

  static _initiateFirebase(){
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
