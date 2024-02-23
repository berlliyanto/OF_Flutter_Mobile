import 'package:get/get.dart';

import '../controllers/absencerequest_controller.dart';

class AbsencerequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbsencerequestController>(
      () => AbsencerequestController(),
    );
  }
}
