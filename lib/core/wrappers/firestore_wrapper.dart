import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreWrapper {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> storeDataToFirestore(
      {required String uid, required Map<String, String> data}) async {
    final docReference = _firebaseFirestore.collection('users').doc(uid);
    await docReference.set(data);

    return;
  }

  Future<Map<String, dynamic>> getUserInfo({required String uid}) async {
    final userData =
        await _firebaseFirestore.collection('users').doc(uid).get();
    return userData.data()!;
  }

  Future<void> uploadBlogToFirestore(
      {required Map<String, dynamic> data}) async {
    await _firebaseFirestore.collection('blogs').add(data);
  }
}
