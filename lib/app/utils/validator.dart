import 'dart:io';

bool isValidImageExtension(File image) {
  final validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
  String extension = image.path.split('.').last.toLowerCase();
  return validExtensions.contains(extension);
}

dynamic dropdownValue(int value) {
  if (value == 0) return null;

  return value;
}
