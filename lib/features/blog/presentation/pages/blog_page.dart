import 'package:blog_app/core/app_theme/app_colors.dart';
import 'package:blog_app/core/commons/widgets/loading_screen.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AddNewBlogPage()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFetchNoBlogState) {
            // snackbar
          }
        },
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return const LoadingScreen();
          } else if (state is BlogFetchBlogsSuccessState) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  return BlogCard(
                      blogData: state.blogs[index],
                      cardColor: index % 2 == 0
                          ? AppColors.gradient1
                          : AppColors.gradient2);
                });
          }
          return const Center(
            child: Text("No Blogs for now!\nTry adding some."),
          );
        },
      ),
    );
  }
}
