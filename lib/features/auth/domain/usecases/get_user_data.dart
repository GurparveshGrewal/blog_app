import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/commons/entities/my_user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';

class GetUserDataUsecase extends Usecase<MyUser, GetUserDataParams> {
  final AuthRepository _authRepository;

  GetUserDataUsecase(this._authRepository);

  @override
  Future<MyUser> call(GetUserDataParams params) async {
    final user = await _authRepository.getUserData(
      uid: params.id,
    );

    return user;
  }
}

class GetUserDataParams {
  final String id;

  GetUserDataParams({
    required this.id,
  });
}
