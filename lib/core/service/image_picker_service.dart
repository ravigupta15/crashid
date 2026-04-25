import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

  static Future<List<File>> pickMultipleImagesFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage(imageQuality: 90);
      return images.map((image) => File(image.path)).toList();
    } catch (e) {
      print('Error picking multiple images: $e');
      return [];
    }
  }

  static Future<File?> pickPdfFile() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );
      final path = result?.files.single.path;
      if (path == null) return null;
      return File(path);
    } catch (e) {
      print('Error picking pdf: $e');
      return null;
    }
  }
}
