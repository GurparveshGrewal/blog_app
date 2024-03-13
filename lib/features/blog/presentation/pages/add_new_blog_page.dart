import 'dart:io';

import 'package:blog_app/core/app_theme/app_colors.dart';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_text_field_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final ImagePicker _imagePicker = ImagePicker();
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
    print("in picker");
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
            onPressed: () {},
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            child: const Column(
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
                                  color: _selectedCategories.contains(type)
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
                  controller: _contentController, hintText: 'Blog Content'),
            ],
          ),
        ),
      ),
    );
  }
}
