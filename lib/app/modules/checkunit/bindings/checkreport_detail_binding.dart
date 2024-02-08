import 'package:get/get.dart';

import '../controllers/checkreport_detail_controller.dart';

class CheckreportDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckreportDetailController>(
      () => CheckreportDetailController(),
    );
  }
}
