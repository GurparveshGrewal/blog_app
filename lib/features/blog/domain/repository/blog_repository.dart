import 'dart:io';

import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';

abstract class BlogRepository {
  Future<String> uploadBlogImage({
    required String blogId,
    required File image,
  });

  Future<void> uploadBlogToFirestore({
    required Blog blogData,
  });
}
