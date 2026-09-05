part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String name;
  final String password;

  new({
    required this.email,
    required this.name,
    required this.password,
  });
}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  new({required this.email, required this.password});
}
