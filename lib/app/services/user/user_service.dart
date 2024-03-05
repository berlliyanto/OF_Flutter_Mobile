import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class UserService extends BaseServices {
  Future<Response> userProfile({String query = ""}) async {
    return await get(path: "/user/profile", query: query);
  }

  Future<Response> updateProfile(
      {required FormData data, required int id}) async {
    return await postFormData(path: "/user/update/$id", data: data);
  }

  Future<Response> updatePassword({required Map<String, dynamic> data}) async {
    return await put(path: "/user/update-password", data: data);
  }

  Future<Response> indexOperator({String query = ""}) async {
    return await get(path: "/user/operators", query: query);
  }

  Future<Response> showOperator({required String id, String query = ""}) async {
    return await get(path: "/user/show/$id", query: query);
  }

  Future<Response> resetPassword({required int id}) async {
    return await post(path: "/user/reset-password", data: {"user_id": id});
  }

  Future<Response> destroy({required int id}) async {
    return await delete(path: "/user/destroy/$id");
  }
}
