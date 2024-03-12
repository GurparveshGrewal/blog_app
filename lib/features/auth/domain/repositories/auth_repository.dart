import 'package:blog_app/features/auth/domain/entities/my_user.dart';

abstract class AuthRepository {
  Future<MyUser> signupWithEmailAndPassword({
    required String userName,
    required String email,
    required String password,
  });

  Future<MyUser> signinWithEmailAndPassword({
    required String email,
    required String password,
  });
}
