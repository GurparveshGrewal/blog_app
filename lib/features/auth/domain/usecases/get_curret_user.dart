import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/commons/entities/my_user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase extends Usecase<MyUser, void> {
  final AuthRepository _authRepository;

  GetCurrentUserUsecase(this._authRepository);

  @override
  Future<MyUser> call(params) async {
    final user = await _authRepository.getCurrentUser();

    return user;
  }
}
