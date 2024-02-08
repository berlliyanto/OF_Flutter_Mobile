import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRView extends GetView {
  const QRView({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic qr = Get.arguments;
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        child: InteractiveViewer(
          panEnabled: false,
          boundaryMargin: const EdgeInsets.all(20.0),
          minScale: 0.5,
          maxScale: 2.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImageView(
                  data: "${qr['id'].toString()}-${qr['form_code']}",
                  version: QrVersions.auto,
                  size: 200),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
