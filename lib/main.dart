import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/dependency/dependency_injection.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final globalState = Get.find<GlobalState>();

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
          primary: const Color(0xFF000000),
        ),
      ),
      debugShowCheckedModeBanner: false,
      defaultTransition: globalState.getPageTransition,
      transitionDuration:
          Duration(milliseconds: globalState.getTransitionDuration),
      title: "Forklift App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
