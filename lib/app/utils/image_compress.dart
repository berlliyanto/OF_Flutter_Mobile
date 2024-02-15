import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> getSizeCompressedImage(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    quality: 80,
  );
  log("Original File Size : ${file.lengthSync()} Bytes");
  log("Compressed File Size : ${result!.length} Bytes");
  return result;
}

Future<File> getCompressedImage(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 75,
  );

  if (result == null) {
    return file;
  } else {
    return File(result.path);
  }
}
