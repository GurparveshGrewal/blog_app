import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_image_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogImageUsecase _uploadBlogImageUsecase;
  final UploadBlogUsecase _uploadBlogUsecase;
  BlogBloc({
    required UploadBlogImageUsecase uploadBlogImageUsecase,
    required UploadBlogUsecase uploadBlog,
  })  : _uploadBlogImageUsecase = uploadBlogImageUsecase,
        _uploadBlogUsecase = uploadBlog,
        super(BlogInitialState()) {
    on<BlogEvent>((event, emit) => emit(BlogLoadingState()));
    on<BlogUploadProcessEvent>(blogUploadProcessEvent);
  }

  FutureOr<void> blogUploadProcessEvent(
      BlogUploadProcessEvent event, Emitter<BlogState> emit) async {
    final imageUrl = await _uploadBlogImageUsecase(
        UploadBlogImageParams(blogId: event.blogId, image: event.imageFile));

    if (imageUrl != 'error') {
      await _uploadBlogUsecase(UploadBlogParams(
          blog: Blog(
        id: event.blogId,
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
        topics: event.topics,
      )));

      emit(BlogUploadSuccessState());
    }
  }
}
