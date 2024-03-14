part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitialState extends BlogState {}

final class BlogLoadingState extends BlogState {}

final class BlogUploadSuccessState extends BlogState {}

final class BlogUploadErrorState extends BlogState {}
