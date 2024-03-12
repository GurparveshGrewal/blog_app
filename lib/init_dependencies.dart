import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
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

  // Blocs
  serviceLocator.registerLazySingleton(() => AuthBloc(
        signUpUsecase: serviceLocator(),
        signInUsecase: serviceLocator(),
      ));
}
