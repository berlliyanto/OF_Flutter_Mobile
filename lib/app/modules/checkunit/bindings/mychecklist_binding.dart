import 'package:get/get.dart';

import '../controllers/mychecklist_controller.dart';

class MychecklistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MychecklistController>(
      () => MychecklistController(),
    );
  }
}
