part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class BlogFetchAllBlogsEvent extends BlogEvent {}

class BlogUploadProcessEvent extends BlogEvent {
  final String posterId;
  final String blogId;
  final File imageFile;
  final String title;
  final String content;
  final List<String> topics;

  BlogUploadProcessEvent({
    required this.blogId,
    required this.posterId,
    required this.imageFile,
    required this.title,
    required this.content,
    required this.topics,
  });
}
