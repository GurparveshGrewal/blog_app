import 'dart:developer';

import 'package:blog_app/features/auth/data/models/my_user_model.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/wrappers/firebase_auth_wrapper.dart';
import 'package:blog_app/wrappers/firestore_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    return _getUser(() async => await _firebaseAuthWrapper
        .signinWithEmailAndPassword(email: email, password: password));
  }

  @override
  Future<MyUserModel> signupWithEmailAndPassword(
      {required String userName,
      required String email,
      required String password}) async {
    final myUser = await _getUser(() async => await _firebaseAuthWrapper
        .signupWithEmailAndPassword(email: email, password: password));

    if (myUser != MyUserModel.empty) {
      await _firestoreWrapper.storeDataToFirestore(uid: myUser.uid, data: {
        'email': myUser.email,
        'username': myUser.name,
        'createdAt': DateTime.now().toIso8601String()
      });
    }

    return myUser;
  }

  Future<MyUserModel> _getUser(Future<User?> Function() fc) async {
    try {
      final user = await fc();

      if (user != null) {
        return MyUserModel(
          uid: user.uid,
          name: '',
          email: user.email!,
        );
      }
      return MyUserModel.empty;
    } catch (e) {
      log(e.toString());
      return MyUserModel.empty;
    }
  }
}
