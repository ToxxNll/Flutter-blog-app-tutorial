import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/usecases/current_user.dart';
import 'package:app/features/auth/domain/usecases/user_login.dart';
import 'package:app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;

  AuthBloc({
    required this._userSignUp,
    required this._userLogin,
    required this._currentUser,
  }) : super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsLoggedIn>(_isLoggedIn);
  }

  void _isLoggedIn(
    AuthIsLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _currentUser(NoParams());
    response.fold((l) => emit(AuthFailure(l.message)), (r) {
      print(r.email);
      emit(AuthSuccess(r));
    });
  }

  void _onAuthSignUp(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _userSignUp(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      );
      response.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSuccess(r)),
      );
    } catch (_) {
      emit(
        AuthFailure(
          'Unable to create your account. Please try again.',
        ),
      );
    }
  }

  void _onAuthLogin(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _userLogin(
        UserLoginParams(
          email: event.email,
          password: event.password,
        ),
      );
      response.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSuccess(r)),
      );
    } catch (_) {
      emit(
        AuthFailure(
          'Unable to create your account. Please try again.',
        ),
      );
    }
  }
}
