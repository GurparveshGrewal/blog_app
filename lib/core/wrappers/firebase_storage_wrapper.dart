import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageWrapper {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> storeImageToStorage(
      {required String blogId, required File image}) async {
    try {
      final storageRef =
          _firebaseStorage.ref().child('blog-images').child('$blogId.jpg');

      await storageRef.putFile(image);
      final imageUrl = await storageRef.getDownloadURL();

      return imageUrl;
    } catch (error) {
      log(error.toString());
      return 'error';
    }
  }
}
