import 'package:of_flutter_mobile/app/routes/app_pages.dart';

List<ListCheckUnitModel> listCheckUnit = [
  ListCheckUnitModel(
    title: "LIST FORKLIFT",
    routes: Routes.LISTFORKLIFT,
    image1: "assets/images/forklift.png",
    image2: "assets/images/list-forklift.png",
  ),
  ListCheckUnitModel(
    title: "ADD UNIT",
    routes: Routes.ADDUNIT,
    image1: "assets/images/forklift.png",
    image2: "assets/images/add-unit.png",
  ),
  ListCheckUnitModel(
    title: "CHECKLIST REPORT",
    routes: Routes.CHECKREPORT,
    image1: "assets/images/forklift.png",
    image2: "assets/images/check-report.png",
  ),
  ListCheckUnitModel(
    title: "LIST OPERATOR",
    routes: Routes.LISTOPERATOR,
    image1: "assets/images/list-operator.png",
  ),
  ListCheckUnitModel(
    title: "CHECKLIST HISTORY",
    routes: Routes.CHECKHISTORY,
    image1: "assets/images/forklift.png",
  ),
];

class ListCheckUnitModel {
  final String title, routes, image1, image2;

  ListCheckUnitModel({
    required this.title,
    required this.routes,
    required this.image1,
    this.image2 = "",
  });
}
