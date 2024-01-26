import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

  Future<void> onRefresh() async {}

  void increment() => count.value++;
}
