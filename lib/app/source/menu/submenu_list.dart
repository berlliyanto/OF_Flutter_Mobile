import 'package:of_flutter_mobile/app/routes/app_pages.dart';

class SubMenuModel {
  final String title, routes, image1, image2;
  final String permissions;

  SubMenuModel({
    required this.title,
    required this.routes,
    required this.image1,
    this.image2 = "",
    this.permissions = "",
  });
}

//CHECK UNIT
List<SubMenuModel> listCheckUnit = [
  SubMenuModel(
    title: "LIST FORKLIFT",
    routes: Routes.LISTFORKLIFT,
    image1: "assets/images/forklift.png",
    image2: "assets/images/list-forklift.png",
    permissions: "read-forklift",
  ),
  SubMenuModel(
    title: "ADD UNIT",
    routes: Routes.ADDUNIT,
    image1: "assets/images/forklift.png",
    image2: "assets/images/add-unit.png",
    permissions: "create-forklift",
  ),
  SubMenuModel(
    title: "CHECKLIST REPORT",
    routes: Routes.CHECKREPORT,
    image1: "assets/images/forklift.png",
    image2: "assets/images/check-report.png",
    permissions: "create-checklist",
  ),
  SubMenuModel(
    title: "LIST OPERATOR",
    routes: Routes.LISTOPERATOR,
    image1: "assets/images/list-operator.png",
    permissions: "read-user",
  ),
  SubMenuModel(
    title: "CHECKLIST HISTORY",
    routes: Routes.CHECKHISTORY,
    image1: "assets/images/forklift.png",
    image2: "assets/images/check-history.png",
    permissions: "read-checklist",
  ),
];

//HUMAN CAPITAL
List<SubMenuModel> listHumanCapital = [
  SubMenuModel(
    title: "SALARY SLIP",
    routes: "",
    image1: "assets/images/slip-gaji.png",
    permissions: "read-salary",
  ),
  SubMenuModel(
    title: "LEAVE REQUEST",
    routes: Routes.ABSENCEREQUEST,
    image1: "assets/images/absen.png",
    permissions: "create-paidleave",
  ),
  SubMenuModel(
    title: "ASSESSMENT",
    routes: "",
    image1: "assets/images/penilaian.png",
    permissions: "read-assessment",
  ),
  SubMenuModel(
    title: "LEAVE HISTORY",
    routes: Routes.ABSENCEHISTORY,
    image1: "assets/images/absen.png",
    image2: "assets/images/absen-history.png",
    permissions: "read-paidleave",
  ),
  SubMenuModel(
    title: "APPROVAL",
    routes: Routes.APPROVAL,
    image1: "assets/images/approve.png",
    permissions: "approve-paidleave",
  ),
  SubMenuModel(
    title: "EMPLOYEES",
    routes: Routes.EMPLOYEE,
    image1: "assets/images/leave.png",
    permissions: "read-employee",
  ),
];
