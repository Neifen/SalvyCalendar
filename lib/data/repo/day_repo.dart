import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:salvy_calendar/models/content_type.dart';
import 'package:salvy_calendar/models/media_file_model.dart';

class DayRepo {
  CollectionReference<Map<String, dynamic>> _repo(String corp) {
    return FirebaseFirestore.instance.collection('corps').doc(corp.toLowerCase()).collection('days');
  }

  Future<Map<int, MediaFileModel>> getAll(String corp) async {
    var snapshot = await _repo(corp).get();
    Map<int, MediaFileModel> returnMap = {};

    snapshot.docs.forEach((e) {
      var file = MediaFileModel.fromJson(e.id, e.data());

      //save(corp, file);

      returnMap[file.dayNumber] = file;
    });

    print("All calendar items are loaded, there is ${returnMap.length} days");
    return returnMap;
  }

  save(String corp, MediaFileModel model) async {
    _repo(corp).doc(model.dayNumber.toString()).set(model.toJson());
  }
}
