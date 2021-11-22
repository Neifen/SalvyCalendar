import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PhotoRepo {
  static Future<String> uploadPhoto(String corp, PlatformFile file) {
    if (file.bytes == null) {
      throw StateError('You can not upload an empty photo');
    }
    return FirebaseStorage.instance.ref().child(corp).child(file.name).putData(file.bytes!).then((p0) {
      return p0.ref.getDownloadURL();
    });
  }

  static Future<String> uploadCapture(String corp, Uint8List capture) {
    return FirebaseStorage.instance.ref().child(corp).child("testThumbnail.jpg").putData(capture, SettableMetadata(contentType: 'image/jpg')).then((p0) {
      return p0.ref.getDownloadURL();
    });
  }

  static removePhoto(String path) async {
    await FirebaseStorage.instance.refFromURL(path).delete();
  }
}
