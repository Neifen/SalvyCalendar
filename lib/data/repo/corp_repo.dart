import 'package:cloud_firestore/cloud_firestore.dart';

class CorpRepo {
  CollectionReference<Map<String, dynamic>> _repo() {
    return FirebaseFirestore.instance.collection('corps');
  }

  Future<List<String>> getAll() async {
    var snapshot = await _repo().get();

    var list = snapshot.docs.map((e) {
      return '${e.id[0].toUpperCase()}${e.id.substring(1)}';
    }).toList();
    return list;
  }

  save(String corp) async {
    var doc = _repo().doc(corp.toString());
    await doc.set({});
  }
}
