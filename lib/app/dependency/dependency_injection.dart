import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/dependency/connectivity.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/utils/file_downloader.dart';

class DependencyInjection extends GetxController {
  static void init() {
    Get.put<CheckConnectivity>(CheckConnectivity(), permanent: true);
    Get.put<GlobalState>(GlobalState(), permanent: true);
    Get.put<FileDownloader>(FileDownloader(), permanent: true);
  }
}
