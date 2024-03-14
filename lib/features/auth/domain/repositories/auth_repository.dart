import 'package:blog_app/core/commons/entities/my_user.dart';

abstract class AuthRepository {
  Future<String> signupWithEmailAndPassword({
    required String userName,
    required String email,
    required String password,
  });

  Future<String> signinWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<MyUser> getCurrentUser();

  Future<MyUser> getUserData({
    required String uid,
  });
}
