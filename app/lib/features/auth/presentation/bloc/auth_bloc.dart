import 'package:app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required this._userSignUp}) : super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
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
        emit(AuthFailure('Unable to create your account. Please try again.'));
      }
    });
  }
}
