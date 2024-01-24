import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckConnectivity extends GetxController {
  final Connectivity connectivity = Connectivity();

  void updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Get.rawSnackbar(
          message: "No internet connection",
          backgroundColor: Colors.red[400]!,
          borderRadius: 0,
          isDismissible: false,
          duration: const Duration(days: 1),
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }
}
