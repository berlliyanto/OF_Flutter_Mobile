import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/user_model.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/services/user/user_service.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';

class HomeController extends GetxController {
  var name = "".obs;
  var isLoading = false.obs;
  Future<void> getProfileUser() async {
    isLoading.value = true;
    update();
    final response = await UserService().userProfile();
    if (response.data != null) {
      final UserModel userModel = UserModel.fromJson(response.data['data']);
      name.value = userModel.name!;
      update();
    } else if (response.statusCode == 401 || response.statusCode == 400) {
      removeToken();
      Get.offAllNamed(Routes.LOGIN);
    } else {
      removeToken();
      Get.offAllNamed(Routes.LOGIN);
    }
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getProfileUser();
  }
}
