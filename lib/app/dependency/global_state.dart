import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/services/auth/auth_service.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';

class GlobalState extends GetxController {
  var name = "".obs;
  var roleName = "".obs;

  void handleDrawerMenu(dynamic route) async {
    if (route != null) {
      if (route == Routes.HOME) {
        Get.offAllNamed(Routes.HOME);
      }
      Get.toNamed(route);
      return;
    }

    EasyLoading.show(status: "Logout...");
    final response = await AuthService().logout();
    if (response.data != null) {
      removeUser();
      removeToken();
      Get.offAllNamed(Routes.LOGIN);
    }
    EasyLoading.dismiss();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
