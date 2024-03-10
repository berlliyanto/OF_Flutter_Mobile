import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class SalaryService extends BaseServices {
  Future<Response> indexSalary({String query = ""}) async {
    return await get(path: "/salary/index", query: query);
  }

  Future<Response> storeSalary({required FormData data}) async {
    return await postFormData(data: data, path: "/salary/store");
  }

  Future<Response> destroySalary({required int id}) async {
    return await delete(path: "/salary/destroy/$id");
  }
}
