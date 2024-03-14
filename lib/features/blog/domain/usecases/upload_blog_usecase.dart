import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';

class UploadBlogUsecase extends Usecase<void, UploadBlogParams> {
  final BlogRepository _repository;
  UploadBlogUsecase(this._repository);

  @override
  Future<void> call(UploadBlogParams params) async {
    await _repository.uploadBlogToFirestore(
      blogData: params.blog,
    );
  }
}

class UploadBlogParams {
  final Blog blog;

  UploadBlogParams({
    required this.blog,
  });
}
