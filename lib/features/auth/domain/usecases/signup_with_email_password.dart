import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';

class SignupWithEmailAndPasswordUsecase
    extends Usecase<void, SignupWithEmailAndPasswordUsecaseParams> {
  final AuthRepository _authRepository;

  SignupWithEmailAndPasswordUsecase(this._authRepository);

  @override
  Future<String> call(SignupWithEmailAndPasswordUsecaseParams params) async {
    final uid = await _authRepository.signupWithEmailAndPassword(
      userName: params.name,
      email: params.email,
      password: params.password,
    );

    return uid;
  }
}

class SignupWithEmailAndPasswordUsecaseParams {
  final String name;
  final String email;
  final String password;

  SignupWithEmailAndPasswordUsecaseParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
