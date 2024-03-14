import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';

class FetchAllBlogsUsecase extends Usecase<List<Blog>, void> {
  final BlogRepository _repository;
  FetchAllBlogsUsecase(this._repository);
  @override
  Future<List<Blog>> call(params) async {
    final blogs = await _repository.fetchAllBlogsFromFirestore();
    return blogs;
  }
}
