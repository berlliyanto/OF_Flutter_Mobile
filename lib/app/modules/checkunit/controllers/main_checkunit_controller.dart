import 'package:get/get.dart';

class ChechkunitController extends GetxController {
  //TODO: Implement ChechkunitController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("checkunit");
  }

  void increment() => count.value++;
}
