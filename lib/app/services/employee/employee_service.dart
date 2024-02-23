import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class EmployeeService extends BaseServices {
  Future<Response> index({String query = ""}) async {
    return await get(path: "/employee/index", query: query);
  }

  Future<Response> updateAllowance(
      {required int allowance, required int id, String query = ""}) async {
    return await put(
        path: "/employee/update-allowance/$id",
        data: {"annual_leave_allowance": allowance},
        query: query);
  }
}
