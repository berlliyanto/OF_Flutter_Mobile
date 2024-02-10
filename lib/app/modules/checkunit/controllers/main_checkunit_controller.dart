import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/grid/grid.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/source/menu/checkunit_list.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

class ChechkunitController extends GetxController {
  final GlobalState globalState = Get.find<GlobalState>();
  final ColorPicker colors = ColorPicker();

  //QR SCANNER
  Future<void> scanQR() async {
    String qrValue;

    try {
      qrValue = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (qrValue != "-1") {
        if (qrValue.contains("CS")) {
          List<String> newQrValue = qrValue.split("-");
          if (newQrValue[1].startsWith("CL")) {
            toast(message: "Berhasil Scan QR");
            Get.toNamed(Routes.CHECKREPORT,
                arguments: {'id': int.parse(newQrValue[0])});
          } else {
            toast(message: "QR Code Tidak Valid");
          }
        } else {
          toast(message: "QR Code Tidak Valid");
        }
      } else {
        toast(message: "Gagal Scan QR");
      }
    } on PlatformException {
      qrValue = 'Failed';
      toast(message: "Something Wrong");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  List<Widget> renderMenu() {
    List<Widget> menu = [];
    for (var item in listCheckUnit) {
      if (globalState.getPermissions.contains(item.permissions)) {
        menu.add(GridItem(
          title: item.title,
          image1: item.image1,
          colors: colors,
          image2: item.image2,
          routes: item.routes,
        ).animate().slideY(duration: const Duration(milliseconds: 500)));
      }
    }

    return menu;
  }
}
