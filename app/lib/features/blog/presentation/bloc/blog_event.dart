part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent{
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