import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/my_user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';

class SigninWithEmailAndPasswordUsecase
    extends Usecase<MyUser, SigninWithEmailAndPasswordUsecaseParams> {
  final AuthRepository _authRepository;

  SigninWithEmailAndPasswordUsecase(this._authRepository);

  @override
  Future<MyUser> call(SigninWithEmailAndPasswordUsecaseParams params) async {
    final user = await _authRepository.signinWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
    return user;
  }
}

class SigninWithEmailAndPasswordUsecaseParams {
  final String email;
  final String password;

  SigninWithEmailAndPasswordUsecaseParams({
    required this.email,
    required this.password,
  });
}
