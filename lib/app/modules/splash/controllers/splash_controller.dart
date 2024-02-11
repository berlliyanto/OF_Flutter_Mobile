import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/dialog/awesome_dialog.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/heading.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/components/widgets/toast/toast.dart';
import 'package:of_flutter_mobile/app/config/app_config.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/models/appversion_model.dart';
import 'package:of_flutter_mobile/app/models/user_model.dart';
import 'package:of_flutter_mobile/app/services/app_service.dart';
import 'package:of_flutter_mobile/app/services/user/user_service.dart';
import 'package:of_flutter_mobile/app/utils/token.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/link.dart';

class SplashController extends GetxController {
  final globalState = Get.find<GlobalState>();
  final AppConfig appConfig = AppConfig();

  Future checkVersion() async {
    final response = await AppVersionService().appVersion();
    final int installedBuildNumber = appConfig.getBuildNumber;
    if (response.data != null) {
      AppVersionModel versionModel =
          AppVersionModel.fromJson(response.data['data']);
      if (installedBuildNumber < versionModel.buildNumber!) {
        awesomeDialog(
          title: "",
          desc: "",
          onDismissCallback: (T) {
            Future.delayed(const Duration(seconds: 1), () {
              checkAuth();
            });
          },
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Heading(heading: "h2", text: "Update Available"),
              const Heading(
                  heading: "h3", text: "Please update to the latest version"),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Future.delayed(const Duration(seconds: 1), () {
                        checkAuth();
                      });
                    },
                    child: const Paragraph(text: "Not Now"),
                  ),
                  Link(
                    uri: Uri.parse(appConfig.urlApk.toString()),
                    target: LinkTarget.blank,
                    builder: (context, followLink) => ElevatedButton(
                      onPressed: followLink,
                      child: const Paragraph(text: "Download"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          checkAuth();
        });
      }
    }
  }

  void checkAuth() async {
    String token = getToken();
    if (token.isEmpty || token == "") {
      Get.offNamed('/login');
    } else {
      final response = await UserService().userProfile();
      if (response.statusCode == 200) {
        final UserModel userModel = UserModel.fromJson(response.data['data']);
        globalState.setPermissions = userModel.rolePermissions!;
        setUser({
          "name": userModel.name,
          "role": userModel.roles![0].name,
          "image": userModel.image ?? ""
        });
        Get.offNamed('/home');
      } else {
        removeToken();
        Get.offNamed('/login');
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    if (await Permission.notification.isDenied) {
      final notif = await Permission.notification.request();
      if (notif.isGranted) {
        toast(message: "Permission Granted");
      } else {
        toast(message: "Permission Denied");
      }
    }

    Future.delayed(const Duration(seconds: 1), () {
      checkVersion();
    });
  }
}
