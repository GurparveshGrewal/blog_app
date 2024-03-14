import 'dart:developer';
import 'dart:io';

import 'package:blog_app/core/wrappers/firebase_storage_wrapper.dart';
import 'package:blog_app/core/wrappers/firestore_wrapper.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';

class BlogRepositoryImpl extends BlogRepository {
  final FirestoreWrapper _firestoreWrapper;
  final FirebaseStorageWrapper _firebaseStorageWrapper;

  BlogRepositoryImpl(
    this._firestoreWrapper,
    this._firebaseStorageWrapper,
  );

  @override
  Future<String> uploadBlogImage(
      {required String blogId, required File image}) async {
    try {
      final imageUrl = await _firebaseStorageWrapper.storeImageToStorage(
          blogId: blogId, image: image);

      if (imageUrl != 'error') {
        return imageUrl;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  @override
  Future<void> uploadBlogToFirestore({required Blog blogData}) async {
    final blogModelData = BlogModel.fromEntity(blogData);
    try {
      await _firestoreWrapper.uploadBlogToFirestore(
          data: blogModelData.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> fetchAllBlogsFromFirestore() async {
    try {
      final List<BlogModel> blogs = [];
      final rawBlogsData = await _firestoreWrapper.fetchAllBlogs();

      if (rawBlogsData.isNotEmpty) {
        for (var blog in rawBlogsData) {
          blogs.add(BlogModel(
            id: blog['id'],
            posterId: blog['poster_id'],
            title: blog['title'],
            content: blog['content'],
            imageUrl: blog['image_url'],
            topics: _getTopics(blog['topics']),
            createdAt: DateTime.parse(blog['created_at']),
          ));
        }
      }
      return blogs;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  List<String> _getTopics(List rawTopics) {
    final List<String> topics = [];
    for (String topic in rawTopics) {
      topics.add(topic);
    }

    return topics;
  }
}
