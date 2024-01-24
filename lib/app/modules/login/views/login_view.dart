import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/modules/login/local_widgets/form_login.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(builder: (builder) {
        return BackgroundLayout(
          showBottom: true,
          showLogo: controller.isLogoVisible.value,
          child: MainLayout(
            crossAxis: CrossAxisAlignment.start,
            paddingLR: 15,
            children: <Widget>[
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
              formLogin(
                  formKey: builder.formKey, title: "Sign In", builder: builder)
            ],
          ),
        );
      }),
    );
  }
}
