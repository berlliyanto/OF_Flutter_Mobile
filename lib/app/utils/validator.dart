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

bool checkQueryIsExist(String query, List<String> queryKey) {
  bool condition = false;
  for (var element in queryKey) {
    if (query.contains(element)) {
      condition = true;
    }
  }

  return condition;
}

// Pengecekan untuk checkbox, entah kenapa kalau ngirim data boolean ke API tidak bisa harus dalam bentuk 1 / 0, jika
// true / false malah error column sedangkan checkbox membutuhkan nilai true / false untuk state nya, maka dibuat
// validator ini
bool isChecked(Map<String, dynamic> data, String itemKey, bool isOk) {
  if (data[itemKey] == null) {
    return false;
  } else {
    if (isOk) {
      if (data[itemKey] == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      if (data[itemKey] == 1) {
        return false;
      } else {
        return true;
      }
    }
  }
}
