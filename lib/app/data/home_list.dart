import 'package:flutter/material.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';

List<ListHomeModel> listHome = [
  ListHomeModel(
      routes: Routes.CHECHKUNIT,
      title: "Forklift Check Unit",
      icon: Icons.checklist_sharp),
];

class ListHomeModel {
  final String title, routes;
  final IconData icon;

  ListHomeModel({
    required this.title,
    required this.routes,
    required this.icon,
  });
}
