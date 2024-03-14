import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';

class UploadBlogImageUsecase extends Usecase<String, UploadBlogImageParams> {
  final BlogRepository _repository;
  UploadBlogImageUsecase(this._repository);

  @override
  Future<String> call(UploadBlogImageParams params) async {
    final imageUrl = await _repository.uploadBlogImage(
      blogId: params.blogId,
      image: params.image,
    );

    return imageUrl;
  }
}

class UploadBlogImageParams {
  final String blogId;
  final File image;

  UploadBlogImageParams({
    required this.blogId,
    required this.image,
  });
}
