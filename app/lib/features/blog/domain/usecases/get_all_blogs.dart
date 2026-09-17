import 'package:app/core/error/failures.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/blog/domain/entity/blog.dart';
import 'package:app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  new(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
