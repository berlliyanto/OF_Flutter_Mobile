import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class CheckListService extends BaseServices {
  Future<Response> storeCheckList({required FormData data}) async {
    return await postFormData(path: '/checklist/store', data: data);
  }
}
