import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      String token = getToken();
      print(token);
      if (token.isEmpty || token == "") {
        Get.offNamed('/login');
      } else {
        Get.offNamed('/home');
      }
    });
  }
}
