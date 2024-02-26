import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/modules/login/local_widgets/form_login.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(builder: (builder) {
        return BackgroundLayout(
          showTop: true,
          showBottom: true,
          showLogo: builder.isLogoVisible.value,
          child: MainLayout(
            isScrollable: true,
            crossAxis: CrossAxisAlignment.start,
            mainAxis: MainAxisAlignment.center,
            paddingLR: 15,
            children: <Widget>[
              Gap(Get.height * 0.2),
              const Heading(
                heading: "h1",
                text: "CARGILL OPERATOR MANAGEMENT SYSTEM",
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const Center(
                child: Hero(
                  tag: "image_auth",
                  child: Image(
                    image: AssetImage("assets/images/logo-splash.png"),
                  ),
                ),
              ),
              formLogin(formKey: formKey, title: "Sign In", builder: builder)
                  .animate()
                  .fade(duration: 800.ms)
            ],
          ),
        );
      }),
    );
  }
}
