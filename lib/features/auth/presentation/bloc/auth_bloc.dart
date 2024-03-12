import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/usecases/signin_with_email_password.dart';
import "package:meta/meta.dart";
import 'package:blog_app/features/auth/data/models/my_user_model.dart';
import 'package:blog_app/features/auth/domain/usecases/signup_with_email_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupWithEmailAndPasswordUsecase _signupWithEmailAndPasswordUsecase;
  final SigninWithEmailAndPasswordUsecase _signinWithEmailAndPasswordUsecase;
  AuthBloc({
    required SignupWithEmailAndPasswordUsecase signUpUsecase,
    required SigninWithEmailAndPasswordUsecase signInUsecase,
  })  : _signupWithEmailAndPasswordUsecase = signUpUsecase,
        _signinWithEmailAndPasswordUsecase = signInUsecase,
        super(AuthInitialState()) {
    on<AuthSignUpProcessEvent>(authSignUpProcessEvent);
    on<AuthSignInProcessEvent>(authSignInProcessEvent);
  }

  FutureOr<void> authSignUpProcessEvent(
      AuthSignUpProcessEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final res = await _signupWithEmailAndPasswordUsecase(
        SignupWithEmailAndPasswordUsecaseParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    if (res != MyUserModel.empty) {
      emit(AuthSuccessState(
        uid: res.uid,
      ));
    } else {
      emit(AuthFailureState());
    }
  }

  FutureOr<void> authSignInProcessEvent(
      AuthSignInProcessEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final res = await _signinWithEmailAndPasswordUsecase(
        SigninWithEmailAndPasswordUsecaseParams(
      email: event.email,
      password: event.password,
    ));

    if (res != MyUserModel.empty) {
      emit(AuthSuccessState(
        uid: res.uid,
      ));
    } else {
      emit(AuthFailureState());
    }
  }
}
