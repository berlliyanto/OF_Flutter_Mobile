import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class PaidLeaveServices extends BaseServices {
  Future<Response> types() async {
    return await get(path: "/paidleave/types");
  }

  Future<Response> index({String query = ""}) async {
    return await get(path: "/paidleave/index", query: query);
  }

  Future<Response> show({required int id}) async {
    return await get(path: "/paidleave/show/$id");
  }

  Future<Response> store({required Map<String, dynamic> data}) async {
    return await post(path: "/paidleave/store", data: data);
  }

  Future<Response> needApprove({String query = ""}) async {
    return await get(path: "/paidleave/need-approve", query: query);
  }

  Future<Response> approve(
      {required Map<String, dynamic> data, required int id}) async {
    return await put(path: "/paidleave/approve/$id", data: data);
  }
}
