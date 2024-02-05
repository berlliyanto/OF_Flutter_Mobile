import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/models/user_model.dart';
import 'package:of_flutter_mobile/app/services/user/user_service.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  void checkAuth() async {
    String token = getToken();
    if (token.isEmpty || token == "") {
      Get.offNamed('/login');
    } else {
      final response = await UserService().userProfile();
      if (response.statusCode == 200) {
        final box = GetStorage();
        final UserModel userModel = UserModel.fromJson(response.data['data']);
        box.write(
            "user", {"name": userModel.name, "role": userModel.roles!.name});
        Get.offNamed('/home');
      } else {
        Get.offNamed('/login');
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    if (await Permission.notification.isDenied) {
      final notif = await Permission.notification.request();
      if (notif.isGranted) {
        toast(message: "Permission Granted");
      } else {
        toast(message: "Permission Denied");
      }
    }

    Future.delayed(const Duration(seconds: 2), () {
      checkAuth();
    });
  }
}
