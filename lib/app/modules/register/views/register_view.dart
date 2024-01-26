import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/layout/background_layout.dart';
import 'package:of_flutter_mobile/app/components/layout/main_layout.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/modules/register/local_widgets/form_register.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(builder: (builder) {
        return BackgroundLayout(
          showTop: true,
          showBottom: true,
          showLogo: false,
          child: MainLayout(
            refreshController: refreshController,
            onRefresh: () {
              refreshController.refreshCompleted();
            },
            isScrollable: true,
            crossAxis: CrossAxisAlignment.start,
            mainAxis: MainAxisAlignment.center,
            paddingLR: 15,
            children: <Widget>[
              const Gap(100),
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
