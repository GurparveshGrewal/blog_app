import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/commons/cubit/app_user/app_user_cubit.dart';
import 'package:blog_app/core/commons/entities/my_user.dart';
import 'package:blog_app/features/auth/domain/usecases/get_curret_user.dart';
import 'package:blog_app/features/auth/domain/usecases/get_user_data.dart';
import 'package:blog_app/features/auth/domain/usecases/signin_with_email_password.dart';
import "package:meta/meta.dart";
import 'package:blog_app/features/auth/domain/usecases/signup_with_email_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUserCubit _appUserCubit;
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final SignupWithEmailAndPasswordUsecase _signupWithEmailAndPasswordUsecase;
  final SigninWithEmailAndPasswordUsecase _signinWithEmailAndPasswordUsecase;
  final GetUserDataUsecase _getUserDataUsecase;
  AuthBloc({
    required AppUserCubit appUserCubit,
    required GetCurrentUserUsecase getCurrentUser,
    required SignupWithEmailAndPasswordUsecase signUpUsecase,
    required SigninWithEmailAndPasswordUsecase signInUsecase,
    required GetUserDataUsecase getUserData,
  })  : _appUserCubit = appUserCubit,
        _getCurrentUserUsecase = getCurrentUser,
        _signupWithEmailAndPasswordUsecase = signUpUsecase,
        _signinWithEmailAndPasswordUsecase = signInUsecase,
        _getUserDataUsecase = getUserData,
        super(AuthInitialState()) {
    on<AuthEvent>((_, emit) => emit(AuthLoadingState()));
    on<AuthIsUserLoggedIn>(authIsUserLoggedIn);
    on<AuthSignUpProcessEvent>(authSignUpProcessEvent);
    on<AuthSignInProcessEvent>(authSignInProcessEvent);
  }

  FutureOr<void> authIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final user = await _getCurrentUserUsecase({});

    if (user.uid != '') {
      _emitAuthSuccess(user, emit);
    } else {
      emit(AuthFailureState(
          'Something went wrong!\nMake sure you have internet access.'));
    }
  }

  FutureOr<void> authSignUpProcessEvent(
      AuthSignUpProcessEvent event, Emitter<AuthState> emit) async {
    final uid = await _signupWithEmailAndPasswordUsecase(
        SignupWithEmailAndPasswordUsecaseParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    if (uid == 'no-internet') {
      emit(AuthFailureState('No internet connection.'));
    }

    if (uid != '') {
      final myUser = await _getUserDataUsecase(GetUserDataParams(id: uid));
      _emitAuthSuccess(myUser, emit);
    } else {
      emit(AuthFailureState('Something went wrong.'));
    }
  }

  FutureOr<void> authSignInProcessEvent(
      AuthSignInProcessEvent event, Emitter<AuthState> emit) async {
    final uid = await _signinWithEmailAndPasswordUsecase(
        SigninWithEmailAndPasswordUsecaseParams(
      email: event.email,
      password: event.password,
    ));

    if (uid == 'no-internet') {
      emit(AuthFailureState('No internet connection.'));
    }

    if (uid != '') {
      final myUser = await _getUserDataUsecase(GetUserDataParams(id: uid));
      _emitAuthSuccess(myUser, emit);
    } else {
      emit(AuthFailureState('Something went wrong.'));
    }
  }

  void _emitAuthSuccess(MyUser currentUser, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(currentUser);
    emit(AuthSuccessState(uid: currentUser.uid));
  }
}
