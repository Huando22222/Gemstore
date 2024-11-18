import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mevivu_task2/models/user.dart';
import 'package:mevivu_task2/routes/app_routes.dart';
import 'package:mevivu_task2/services/api_service.dart';

class AuthService extends GetxService {
  final ApiService _apiService = ApiService();
  final box = GetStorage();

  Rxn<User> currentUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    if (box.read('user') != null) {
      currentUser.value = User.fromMap(box.read('user'));
    }
  }

  Future<bool> loginUser(
      {required String username, required String password}) async {
    try {
      final res = await _apiService.post(
        '/user/login',
        body: {
          'username': username,
          'password': password,
        },
      );

      if (res.statusCode == 200) {
        debugPrint(currentUser.value.toString());
        currentUser.value = User.fromMap(json.decode(res.body));
      }

      if (currentUser.value != null) {
        box.write('user', currentUser.value!.toMap());
      }
      return currentUser.value != null;
    } catch (e) {
      return false;
    }
  }

  void logout() {
    box.erase();
    currentUser.value = null;
    // box.remove('user');
    Get.offAllNamed(AppRoutes.homePage); //error
  }
}
