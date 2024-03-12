import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';

class SigninWithEmailAndPasswordUsecase
    extends Usecase<String, SigninWithEmailAndPasswordUsecaseParams> {
  final AuthRepository _authRepository;

  SigninWithEmailAndPasswordUsecase(this._authRepository);

  @override
  Future<String> call(SigninWithEmailAndPasswordUsecaseParams params) async {
    final uid = await _authRepository.signinWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    return uid;
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
