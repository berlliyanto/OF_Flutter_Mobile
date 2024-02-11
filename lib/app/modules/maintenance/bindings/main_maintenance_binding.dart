import 'package:get/get.dart';

import '../controllers/main_maintenance_controller.dart';

class MaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaintenanceController>(
      () => MaintenanceController(),
    );
  }
}
