import 'package:dio/dio.dart';
import 'package:of_flutter_mobile/app/services/base_service.dart';

class PicService extends BaseServices {
  Future<Response> indexPic() async {
    return await get(path: '/pic/index');
  }
}
