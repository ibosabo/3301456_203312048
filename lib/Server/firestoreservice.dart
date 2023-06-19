import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).add(data);
      print('Veri başarıyla eklendi.');
    } catch (e) {
      print('Veri eklenirken bir hata oluştu: $e');
    }
  }

  Future<void> updateData(String collection, String documentID, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(documentID).update(data);
      print('Veri başarıyla güncellendi.');
    } catch (e) {
      print('Veri güncellenirken bir hata oluştu: $e');
    }
  }

  Future<void> deleteData(String collection, String documentID) async {
    try {
      await _firestore.collection(collection).doc(documentID).delete();
      print('Veri başarıyla silindi.');
    } catch (e) {
      print('Veri silinirken bir hata oluştu: $e');
    }
  }
}
