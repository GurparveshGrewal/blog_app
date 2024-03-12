import 'dart:developer';

import 'package:blog_app/features/auth/data/models/my_user_model.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/wrappers/firebase_auth_wrapper.dart';
import 'package:blog_app/wrappers/firestore_wrapper.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthWrapper _firebaseAuthWrapper;
  final FirestoreWrapper _firestoreWrapper;

  AuthRepositoryImpl(
    this._firebaseAuthWrapper,
    this._firestoreWrapper,
  );

  @override
  Future<MyUserModel> signinWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signinWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<MyUserModel> signupWithEmailAndPassword(
      {required String userName,
      required String email,
      required String password}) async {
    try {
      final user = await _firebaseAuthWrapper.signupWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        await _firestoreWrapper.storeDataToFirestore(uid: user.uid, data: {
          'username': userName,
          'email': email,
          'createdAt': DateTime.now().toIso8601String(),
        });
      }

      return MyUserModel(
        uid: user!.uid,
        email: user.email!,
        name: 'name',
      );
    } catch (error) {
      log(error.toString());
      return MyUserModel.empty;
    }
  }
}
