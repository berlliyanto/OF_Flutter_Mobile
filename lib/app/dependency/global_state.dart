import 'package:get/get.dart';

class GlobalState extends GetxController {
  Rx<Transition> pageTransition = Transition.native.obs;
  RxInt transistionDuration = 600.obs;

  set setPageTransition(Transition transition) {
    pageTransition.value = transition;
    update();
  }

  set setTransitionDuration(int duration) {
    transistionDuration.value = duration;

    update();
  }

  Transition get getPageTransition => pageTransition.value;
  int get getTransitionDuration => transistionDuration.value;
}
