import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageGetter {
  //final FirebaseStorage _storage;
  //StorageGetter() : _storage = FirebaseStorage.instance;

  Future<void> getOverview() async {
    ListResult result = await FirebaseStorage.instance.ref().listAll();
    result.items.forEach((Reference ref) {
      print('Found file: $ref');
    });

    result.prefixes.forEach((Reference ref) {
      print('Found directory: $ref');
    });
    // Reference ref = FirebaseStorage.instance.ref('/bern/calendar.txt');
  }
}
