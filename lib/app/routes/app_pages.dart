import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/bindings/checkreport_detail_binding.dart';
import 'package:of_flutter_mobile/app/modules/checkunit/views/checkreport_detail_view.dart';

import '../modules/checkunit/bindings/addunit_binding.dart';
import '../modules/checkunit/bindings/checkhistory_binding.dart';
import '../modules/checkunit/bindings/checkreport_binding.dart';
import '../modules/checkunit/bindings/listforklift_binding.dart';
import '../modules/checkunit/bindings/listoperator_binding.dart';
import '../modules/checkunit/bindings/main_checkunit_binding.dart';
import '../modules/checkunit/views/addunit_view.dart';
import '../modules/checkunit/views/checkhistory_view.dart';
import '../modules/checkunit/views/checkreport_view.dart';
import '../modules/checkunit/views/listforklift_view.dart';
import '../modules/checkunit/views/listoperator_view.dart';
import '../modules/checkunit/views/main_checkunit_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/userprofile/bindings/userprofile_binding.dart';
import '../modules/userprofile/views/userprofile_view.dart';
import '../utils/zoom_image.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CHECKUNIT,
      page: () => ChechkunitView(),
      binding: ChechkunitBinding(),
    ),
    GetPage(
      name: _Paths.LISTFORKLIFT,
      page: () => ListforkliftView(),
      binding: ListforkliftBinding(),
    ),
    GetPage(
      name: _Paths.CHECKREPORT,
      page: () => CheckreportView(),
      binding: CheckreportBinding(),
    ),
    GetPage(
      name: _Paths.ADDUNIT,
      page: () => AddunitView(),
      binding: AddunitBinding(),
    ),
    GetPage(
      name: _Paths.LISTOPERATOR,
      page: () => ListoperatorView(),
      binding: ListoperatorBinding(),
    ),
    GetPage(
      name: _Paths.CHECKHISTORY,
      page: () => CheckhistoryView(),
      binding: CheckhistoryBinding(),
    ),
    GetPage(
      name: _Paths.USERPROFILE,
      page: () => const UserprofileView(),
      binding: UserprofileBinding(),
    ),
    GetPage(
      name: _Paths.ZOOMIMAGE,
      page: () => ZoomImageView(),
    ),
    GetPage(
      name: _Paths.CHECKREPORT_DETAIL,
      page: () => CheckreportDetailView(),
      binding: CheckreportDetailBinding(),
    ),
  ];
}
