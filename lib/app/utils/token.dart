import 'dart:developer';

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
  if (box.read("token") != null) {
    box.remove("token");
  }
}

dynamic getUser() {
  final box = GetStorage();
  Map<String, dynamic> user = {
    "name": "",
    "role": "",
  };
  if (box.read("user") == null) {
    return {"name": "", "role": ""};
  }

  dynamic storageUser = box.read("user");
  if (storageUser["name"] != null) {
    user["name"] = storageUser["name"];
  }

  if (storageUser["role"] != null) {
    user["role"] = storageUser["role"];
  }

  log(user.toString());

  return user;
}

void setUser(Map<String, dynamic> user) {
  if (user.isEmpty) {
    log("Failed set user to storage");
    return;
  }

  final box = GetStorage();
  box.write("user", user);
  log("Success set user to storage");
}

void removeUser() {
  final box = GetStorage();
  if (box.read("user") != null) {
    box.remove("user");
    log("Success remove user from storage");
  }
}
