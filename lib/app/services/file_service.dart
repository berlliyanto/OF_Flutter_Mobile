import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileService extends BaseServices {
  Future<void> downloadImage(String url) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;
    if (storageStatus == PermissionStatus.granted) {
      Directory? directory = await getExternalStorageDirectory();
      await FlutterDownloader.enqueue(
        url: url,
        headers: {},
        saveInPublicStorage: true,
        savedDir: directory!.path,
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      toast(message: "Permission Denied");
    }
  }

  Future<void> downloadDoc(String url) async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;

    final storageStatus = android.version.sdkInt < 33
        ? await Permission.storage.request()
        : PermissionStatus.granted;
    if (storageStatus == PermissionStatus.granted) {
      Directory? directory = await getExternalStorageDirectory();
      await FlutterDownloader.enqueue(
        url: url,
        headers: {},
        saveInPublicStorage: true,
        savedDir: directory!.path,
        showNotification: true,
        openFileFromNotification: true,
      );
    } else {
      toast(message: "Permission Denied");
    }
  }
}
