import 'package:app/core/error/failures.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/core/entities/user.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  new(this.authRepository);

  @override
  Future<Either<Failure, User>> call(
    UserLoginParams params,
  ) async {
    return authRepository.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  new({required this.email, required this.password});
}
