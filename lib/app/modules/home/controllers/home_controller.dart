import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/services/user/user_service.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';

class HomeController extends GetxController {
  Future<void> getProfileUser() async {
    final response = await UserService().userProfile();
    if (response.data != null) {
      print(response.data);
    } else if (response.statusCode == 401 || response.statusCode == 400) {
      removeToken();
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProfileUser();
  }
}
