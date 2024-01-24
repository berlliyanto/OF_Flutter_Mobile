import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/dependency/connectivity.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';

class DependencyInjection extends GetxController {
  static void init() {
    Get.put(CheckConnectivity(), permanent: true);
    Get.put(GlobalState(), permanent: true);
  }
}
