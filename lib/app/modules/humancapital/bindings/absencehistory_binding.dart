import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/modules/humancapital/controllers/absencehistory_controller.dart';

class AbsencehistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbsencehistoryController>(
      () => AbsencehistoryController(),
    );
  }
}
