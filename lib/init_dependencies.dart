import 'package:blog_app/core/commons/cubit/app_user/app_user_cubit.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/get_curret_user.dart';
import 'package:blog_app/features/auth/domain/usecases/get_user_data.dart';
import 'package:blog_app/features/auth/domain/usecases/signin_with_email_password.dart';
import 'package:blog_app/features/auth/domain/usecases/signup_with_email_password.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/wrappers/firebase_auth_wrapper.dart';
import 'package:blog_app/wrappers/firestore_wrapper.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  // registering firebase wrapper
  serviceLocator.registerLazySingleton(() => FirebaseAuthWrapper());
  serviceLocator.registerLazySingleton(() => FirestoreWrapper());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ));

  // Usecases
  serviceLocator.registerFactory(
      () => SignupWithEmailAndPasswordUsecase(serviceLocator()));
  serviceLocator.registerFactory(
      () => SigninWithEmailAndPasswordUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetUserDataUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => GetCurrentUserUsecase(serviceLocator()));

  // Blocs
  serviceLocator.registerLazySingleton(() => AuthBloc(
        appUserCubit: serviceLocator(),
        signUpUsecase: serviceLocator(),
        signInUsecase: serviceLocator(),
        getUserData: serviceLocator(),
        getCurrentUser: serviceLocator(),
      ));
}
