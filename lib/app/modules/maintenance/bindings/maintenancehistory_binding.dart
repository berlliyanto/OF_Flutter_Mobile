import 'package:get/get.dart';

import '../controllers/maintenancehistory_controller.dart';

class MaintenancehistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaintenancehistoryController>(
      () => MaintenancehistoryController(),
    );
  }
}
