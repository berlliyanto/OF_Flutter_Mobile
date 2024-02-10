import 'package:of_flutter_mobile/app/routes/app_pages.dart';

List<ListCheckUnitModel> listCheckUnit = [
  ListCheckUnitModel(
    title: "LIST FORKLIFT",
    routes: Routes.LISTFORKLIFT,
    image1: "assets/images/forklift.png",
    image2: "assets/images/list-forklift.png",
    permissions: "read-forklift",
  ),
  ListCheckUnitModel(
    title: "ADD UNIT",
    routes: Routes.ADDUNIT,
    image1: "assets/images/forklift.png",
    image2: "assets/images/add-unit.png",
    permissions: "create-forklift",
  ),
  ListCheckUnitModel(
    title: "CHECKLIST REPORT",
    routes: Routes.CHECKREPORT,
    image1: "assets/images/forklift.png",
    image2: "assets/images/check-report.png",
    permissions: "create-checklist",
  ),
  ListCheckUnitModel(
    title: "LIST OPERATOR",
    routes: Routes.LISTOPERATOR,
    image1: "assets/images/list-operator.png",
    permissions: "read-user",
  ),
  ListCheckUnitModel(
    title: "CHECKLIST HISTORY",
    routes: Routes.CHECKHISTORY,
    image1: "assets/images/forklift.png",
    permissions: "read-checklist",
  ),
];

class ListCheckUnitModel {
  final String title, routes, image1, image2;
  final String permissions;

  ListCheckUnitModel({
    required this.title,
    required this.routes,
    required this.image1,
    this.image2 = "",
    this.permissions = "",
  });
}
