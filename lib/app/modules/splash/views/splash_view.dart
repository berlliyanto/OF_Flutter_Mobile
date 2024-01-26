import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({Key? key}) : super(key: key);

  final colors = ColorPicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundLayout(
        showTop: true,
        showBottom: true,
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                  tag: "image_auth",
                  child: Image(
                      image: AssetImage("assets/images/logo-splash.png"))),
              Hero(
                tag: "h1_auth",
                child: Heading(
                    heading: "h1",
                    text: "CARGIL OPERATOR MANAGEMENT SYSTEM",
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
