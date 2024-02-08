import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';

List<ListMenuModel> listHome = [
  ListMenuModel(
      routes: Routes.CHECKUNIT,
      title: "Forklift Check Unit",
      icon: FontAwesomeIcons.listCheck),
  ListMenuModel(
      routes: "", title: "Human Capital", icon: FontAwesomeIcons.users),
  ListMenuModel(routes: "", title: "Coming Soon", icon: FontAwesomeIcons.gears),
  ListMenuModel(routes: "", title: "Coming Soon", icon: FontAwesomeIcons.gears),
];

class ListMenuModel {
  final String title;
  dynamic routes;
  final IconData icon;

  ListMenuModel({
    required this.title,
    required this.routes,
    required this.icon,
  });
}
