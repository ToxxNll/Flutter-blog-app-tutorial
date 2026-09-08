import 'package:app/core/error/failures.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/core/entities/user.dart';
import 'package:app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  new(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
