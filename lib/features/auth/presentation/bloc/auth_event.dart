part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthIsUserLoggedIn extends AuthEvent {}

final class AuthSignUpProcessEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpProcessEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class AuthSignInProcessEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInProcessEvent({
    required this.email,
    required this.password,
  });
}

final class AuthFailureEvent extends AuthEvent {}

final class AuthSuccessEvent extends AuthEvent {}
