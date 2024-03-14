import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.createdAt,
    required super.topics,
  });

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? createdAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static BlogModel fromEntity(Blog blog) {
    return BlogModel(
      id: blog.id,
      posterId: blog.posterId,
      title: blog.title,
      content: blog.content,
      imageUrl: blog.imageUrl,
      createdAt: blog.createdAt,
      topics: blog.topics,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
