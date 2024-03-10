import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class WorkorderService extends BaseServices {
  Future<Response> indexWorkorder({String query = ""}) async {
    return await get(path: "/workorder/index", query: query);
  }

  Future<Response> myWorkorder() async {
    return await get(path: "/workorder/my-workorder");
  }

  Future<Response> showWorkorder({required int id}) async {
    return await get(path: "/workorder/show/$id");
  }

  Future<Response> storeWorkorder({required Map<String, dynamic> data}) async {
    return await post(path: "/workorder/store", data: data);
  }

  Future<Response> verifyWorkorder(
      {required int id, required Map<String, dynamic> data}) async {
    return await put(path: "/workorder/verify/$id", data: data);
  }

  Future<Response> finishWorkorder(
      {required int id, required Map<String, dynamic> data}) async {
    return await put(path: "/workorder/finish/$id", data: data);
  }

  Future<Response> cancelWorkorder(
      {required int id, required Map<String, dynamic> data}) async {
    return await put(path: "/workorder/cancel/$id", data: data);
  }

  Future<Response> destroyWorkorder({required int id}) async {
    return await delete(path: "/workorder/destroy/$id");
  }
}
