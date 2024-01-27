import 'package:get_storage/get_storage.dart';

String getToken() {
  final box = GetStorage();
  String token = box.read('token');
  return token;
}
