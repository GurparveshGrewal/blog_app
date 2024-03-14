import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreWrapper {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> storeDataToFirestore(
      {required String uid, required Map<String, String> data}) async {
    try {
      final docReference = _firebaseFirestore.collection('users').doc(uid);
      await docReference.set(data);

      return;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, dynamic>> getUserInfo({required String uid}) async {
    try {
      final userData =
          await _firebaseFirestore.collection('users').doc(uid).get();
      return userData.data()!;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> uploadBlogToFirestore(
      {required Map<String, dynamic> data}) async {
    try {
      await _firebaseFirestore.collection('blogs').add(data);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllBlogs() async {
    try {
      final blogsRawData = await _firebaseFirestore.collection('blogs').get();
      return blogsRawData.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
