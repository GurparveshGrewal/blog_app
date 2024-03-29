import 'dart:io';

import 'package:blog_app/core/app_theme/app_colors.dart';
import 'package:blog_app/core/commons/cubit/app_user/app_user_cubit.dart';
import 'package:blog_app/core/commons/widgets/loading_screen.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_text_field_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final List<String> _blogTypes = [
    'Business',
    'Technology',
    'Programming',
    'Sports'
  ];
  final List<String> _selectedCategories = [];
  File? _selectedImage;

  void _pickImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate() &&
                      _selectedCategories.isNotEmpty ||
                  _selectedImage != null) {
                final posterId =
                    (context.read<AppUserCubit>().state as AppUserLoggedIn)
                        .currentUser;
                context.read<BlogBloc>().add(BlogUploadProcessEvent(
                      blogId: const Uuid().v1(),
                      posterId: posterId.uid,
                      imageFile: _selectedImage!,
                      title: _titleController.text.trim(),
                      content: _contentController.text.trim(),
                      topics: _selectedCategories,
                    ));
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogUploadErrorState) {
            // showSnackbar
          } else if (state is BlogUploadSuccessState) {
            Navigator.of(context)
                .pushAndRemoveUntil(BlogPage.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return const LoadingScreen();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _selectedImage != null
                        ? GestureDetector(
                            onTap: _pickImage,
                            child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    ))),
                          )
                        : GestureDetector(
                            onTap: _pickImage,
                            child: DottedBorder(
                                color: AppColors.borderColor,
                                strokeCap: StrokeCap.round,
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                dashPattern: const [15, 4],
                                child: const SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.photo_library,
                                        size: 45,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Select your image",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _blogTypes
                            .map((type) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_selectedCategories.contains(type)) {
                                        _selectedCategories.remove(type);
                                      } else {
                                        _selectedCategories.add(type);
                                      }
                                      setState(() {});
                                    },
                                    child: Chip(
                                        color: _selectedCategories
                                                .contains(type)
                                            ? const MaterialStatePropertyAll(
                                                AppColors.gradient1)
                                            : null,
                                        label: Text(type),
                                        side: _selectedCategories.contains(type)
                                            ? null
                                            : const BorderSide(
                                                color: AppColors.borderColor)),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogTextFieldWidget(
                        controller: _titleController, hintText: 'Blog Title'),
                    const SizedBox(
                      height: 18,
                    ),
                    BlogTextFieldWidget(
                        controller: _contentController,
                        hintText: 'Blog Content'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
