import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:firebase/firebase.dart' as fb;
import 'package:http/http.dart';

class StorageGetter {
  static Map _dayToFileMap;


  static Future<Map> _mapDaysFromFirebase() async {
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

    fb.StorageReference result =
        fb.app().storage().refFromURL("gs://calendarr-260410.appspot.com/Bern");
    Uri url = await result.child("calendar.txt").getDownloadURL();
    var response = await get(url);
    List<String> days = LineSplitter().convert(response.body);

    Map map = Map.fromIterable(days,
        key: (day) => day.split(":")[0], value: (day) => day.split(":")[1]);

    return map;
  }

  static Future<String> getFileName(int day) async {
    if(_dayToFileMap==null){
      _dayToFileMap=await _mapDaysFromFirebase();
    }

    return _dayToFileMap[day.toString()];
  }

  Future<void> printOverview() async {
    fb.ListResult result = await fb
        .app()
        .storage()
        .refFromURL("gs://calendarr-260410.appspot.com/Bern")
        .listAll();

    result.items.forEach((fb.StorageReference ref) {
      print('Found file: $ref');
    });

    result.prefixes.forEach((fb.StorageReference ref) {
      print('Found directory: $ref');
    });
    // Reference ref = FirebaseStorage.instance.ref('/bern/calendar.txt');
  }
}
