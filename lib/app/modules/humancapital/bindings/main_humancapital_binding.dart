import 'package:get/get.dart';

import '../controllers/main_humancapital_controller.dart';

class HumancapitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HumancapitalController>(
      () => HumancapitalController(),
    );
  }
}
