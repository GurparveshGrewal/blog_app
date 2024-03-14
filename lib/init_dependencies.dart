import 'package:blog_app/core/commons/cubit/app_user/app_user_cubit.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/wrappers/firebase_storage_wrapper.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/get_curret_user.dart';
import 'package:blog_app/features/auth/domain/usecases/get_user_data.dart';
import 'package:blog_app/features/auth/domain/usecases/signin_with_email_password.dart';
import 'package:blog_app/features/auth/domain/usecases/signup_with_email_password.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/core/wrappers/firebase_auth_wrapper.dart';
import 'package:blog_app/core/wrappers/firestore_wrapper.dart';
import 'package:blog_app/features/blog/data/repository/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_all_blogs_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_image_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  // registering firebase wrapper
  serviceLocator.registerLazySingleton(() => FirebaseAuthWrapper());
  serviceLocator.registerLazySingleton(() => FirestoreWrapper());
  serviceLocator.registerLazySingleton(() => FirebaseStorageWrapper());

  // core
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        serviceLocator(),
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

_initBlog() {
  serviceLocator.registerFactory<BlogRepository>(() => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ));

  // Blocs
  serviceLocator.registerLazySingleton(() => BlogBloc(
        uploadBlogImageUsecase: serviceLocator(),
        uploadBlog: serviceLocator(),
        fetchAllBlogsUsecase: serviceLocator(),
      ));

  // Usecases
  serviceLocator
      .registerFactory(() => UploadBlogImageUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => UploadBlogUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => FetchAllBlogsUsecase(serviceLocator()));
}
