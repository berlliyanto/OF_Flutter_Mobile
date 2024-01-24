import 'package:get/get.dart';

class GlobalState extends GetxController {
  Transition pageTransition = Transition.noTransition;
  int transistionDuration = 1000;

  set setPageTransition(Transition transition) {
    pageTransition = transition;
  }

  set setTransitionDuration(int duration) {
    transistionDuration = duration;
  }

  Transition get getPageTransition => pageTransition;
  int get getTransitionDuration => transistionDuration;
}
