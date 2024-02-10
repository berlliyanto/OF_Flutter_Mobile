import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/source/menu/home_list.dart';

List<ListMenuModel> listDrawer = [
  ListMenuModel(
    title: "Profile",
    routes: Routes.USERPROFILE,
    icon: FontAwesomeIcons.user,
  ),
  ListMenuModel(
    title: "Change Password",
    routes: Routes.USER_PASSWORD,
    icon: FontAwesomeIcons.fingerprint,
  ),
  ListMenuModel(
    title: "Logout",
    routes: null,
    icon: FontAwesomeIcons.arrowRightFromBracket,
  ),
  ListMenuModel(
    title: "Home",
    routes: Routes.HOME,
    icon: FontAwesomeIcons.house,
  ),
  ListMenuModel(
    routes: Routes.CHECKUNIT,
    title: "Forklift Check Unit",
    icon: FontAwesomeIcons.listCheck,
  ),
  ListMenuModel(
    routes: "",
    title: "Human Capital",
    icon: FontAwesomeIcons.users,
  ),
  ListMenuModel(
    routes: "",
    title: "Coming Soon",
    icon: FontAwesomeIcons.gears,
  ),
  ListMenuModel(
    routes: "",
    title: "Coming Soon",
    icon: FontAwesomeIcons.gears,
  ),
];
