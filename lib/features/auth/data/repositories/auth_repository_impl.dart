import 'dart:developer';

import 'package:blog_app/features/auth/data/models/my_user_model.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/core/wrappers/firebase_auth_wrapper.dart';
import 'package:blog_app/core/wrappers/firestore_wrapper.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthWrapper _firebaseAuthWrapper;
  final FirestoreWrapper _firestoreWrapper;

  AuthRepositoryImpl(
    this._firebaseAuthWrapper,
    this._firestoreWrapper,
  );

  @override
  Future<MyUserModel> getCurrentUser() async {
    try {
      final currentUser = _firebaseAuthWrapper.currentUser;

      if (currentUser != null) {
        final user = await getUserData(uid: currentUser.uid);
        return user;
      }

      return MyUserModel.empty;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> signinWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await _firebaseAuthWrapper.signinWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        return user.uid;
      }
      return '';
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> signupWithEmailAndPassword(
      {required String userName,
      required String email,
      required String password}) async {
    try {
      final user = await _firebaseAuthWrapper.signupWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        await _firestoreWrapper.storeDataToFirestore(uid: user.uid, data: {
          'email': email,
          'username': userName,
          'createdAt': DateTime.now().toIso8601String()
        });

        return user.uid;
      }

      return '';
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUserModel> getUserData({required String uid}) async {
    try {
      final rawUser = await _firestoreWrapper.getUserInfo(uid: uid);

      return MyUserModel(
        uid: uid,
        name: rawUser['username'],
        email: rawUser['email'],
      );
    } catch (e) {
      log(e.toString());
      return MyUserModel.empty;
    }
  }
}
