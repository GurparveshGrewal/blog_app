import 'dart:io';

import 'package:image_picker/image_picker.dart';

final ImagePicker _imagePicker = ImagePicker();

Future<File?> pickImage() async {
  try {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
