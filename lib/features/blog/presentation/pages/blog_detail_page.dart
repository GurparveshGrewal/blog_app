import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/convert_date_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogDetail extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogDetail(blogData: blog));
  final Blog blogData;
  const BlogDetail({
    super.key,
    required this.blogData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogData.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'By Anonymous',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${convertDateTimeToReadable(blogData.createdAt)}.  ${calculateReadingTime(blogData.content)} min',
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        blogData.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  blogData.content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
