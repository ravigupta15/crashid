import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<File?> imagePicker(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? img = await picker.pickImage(
        source: source,
        imageQuality: 90,
      );
      // img?.name;
      print(img);
      if (img == null) return null;
      return File(img.path);
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
}
