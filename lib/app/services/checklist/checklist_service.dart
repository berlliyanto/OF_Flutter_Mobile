import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class CheckListService extends BaseServices {
  Future<Response> storeCheckList({required FormData data}) async {
    return await postFormData(path: '/checklist/store', data: data);
  }

  Future<Response> indexCheckList({String query = ""}) async {
    return await get(path: '/checklist/index', query: query);
  }

  Future<Response> showCheckList({required int id}) async {
    return await get(path: '/checklist/show/$id');
  }

  Future<Response> verify({required int id}) async {
    return await get(path: '/checklist/verify/$id');
  }
}
