import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/modules/register/local_widgets/form_register.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(builder: (builder) {
        return BackgroundLayout(
          showTop: true,
          showBottom: true,
          showLogo: builder.isLogoVisible.value,
          child: MainLayout(
            isScrollable: true,
            crossAxis: CrossAxisAlignment.start,
            mainAxis: MainAxisAlignment.start,
            paddingLR: 15,
            children: <Widget>[
              Gap(Get.height * 0.11),
              const Hero(
                tag: "h1_auth",
                child: Heading(
                    heading: "h1",
                    text: "CARGIL OPERATOR MANAGEMENT SYSTEM",
                    textAlign: TextAlign.center),
              ),
              const Center(
                child: Hero(
                  tag: "image_auth",
                  child: Image(
                    image: AssetImage("assets/images/logo-splash.png"),
                  ),
                ),
              ),
              formRegister(formKey: formKey, title: "Sign Up", builder: builder)
                  .animate()
                  .fade(duration: 800.ms)
            ],
          ),
        );
      }),
    );
  }
}
