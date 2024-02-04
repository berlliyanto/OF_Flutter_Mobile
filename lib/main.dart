import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:of_flutter_mobile/app/config/loading_config.dart';
import 'package:of_flutter_mobile/app/dependency/dependency_injection.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );

  // FlutterError.onError = (details) {
  //   log(details.exceptionAsString(), stackTrace: details.stack);

  //   Get.dialog(
  //     AlertDialog(
  //       title: const Text('Error'),
  //       content: Text(details.exceptionAsString()),
  //     ),
  //   );
  // };

  await GetStorage.init();
  runApp(const MyApp());
  DependencyInjection.init();
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'Lato',
        useMaterial3: true,
        primarySwatch: Colors.cyan,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF146C94),
          brightness: Brightness.light,
          primary: const Color(0xFF181823),
        ),
      ),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      title: "Forklift App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
    );
  }
}
