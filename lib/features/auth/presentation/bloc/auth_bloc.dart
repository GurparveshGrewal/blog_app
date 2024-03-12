import 'dart:async';

import 'package:bloc/bloc.dart';
import "package:meta/meta.dart";
import 'package:blog_app/features/auth/data/models/my_user_model.dart';
import 'package:blog_app/features/auth/domain/usecases/signup_with_email_password.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupWithEmailAndPasswordUsecase _signupWithEmailAndPasswordUsecase;
  AuthBloc({
    required SignupWithEmailAndPasswordUsecase signUpUsecase,
  })  : _signupWithEmailAndPasswordUsecase = signUpUsecase,
        super(AuthInitialState()) {
    on<AuthSignUpProcessEvent>(authSignUpProcessEvent);
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
}
