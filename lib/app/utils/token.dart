import 'package:get_storage/get_storage.dart';

String getToken() {
  final box = GetStorage();
  if (box.read("token") == null) {
    return "";
  }

  String token = box.read("token");

  return token;
}

void setToken(String token) {
  if (token.isEmpty) {
    return;
  }
  final box = GetStorage();
  box.write("token", token);
}

void removeToken() {
  final box = GetStorage();
  box.remove("token");
}

dynamic getUser() {
  final box = GetStorage();
  if (box.read("user") == null) {
    return "";
  }

  dynamic token = box.read("user");

  return token;
}
