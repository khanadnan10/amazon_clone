import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImage() async {
  List<File> images = [];
  try {
    var pickImage = await ImagePicker().pickMultiImage();
    if (pickImage.isNotEmpty && pickImage != null) {
      for (var image in pickImage) {
        images.add(File(image.path));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
