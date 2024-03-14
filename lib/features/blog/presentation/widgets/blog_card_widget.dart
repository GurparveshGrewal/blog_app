import 'package:blog_app/core/app_theme/app_colors.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blogData;
  final Color cardColor;
  const BlogCard({
    super.key,
    required this.blogData,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16).copyWith(bottom: 8),
      padding: const EdgeInsets.all(12),
      height: 200,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: blogData.topics
                      .map((type) => Padding(
                            padding: const EdgeInsets.only(
                              right: 8.0,
                            ),
                            child: Chip(
                              color: MaterialStateProperty.all(
                                  AppColors.backgroundColor),
                              label: Text(type),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                blogData.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text('${calculateReadingTime(blogData.content)} min'),
        ],
      ),
    );
  }
}
