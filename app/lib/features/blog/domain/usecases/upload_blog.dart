import 'dart:io';

import 'package:app/core/error/failures.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/blog/domain/entity/blog.dart';
import 'package:app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  new(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      userId: params.userId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String userId;
  final File image;
  final List<String> topics;

  new({
    required this.title,
    required this.content,
    required this.userId,
    required this.image,
    required this.topics,
  });
}
