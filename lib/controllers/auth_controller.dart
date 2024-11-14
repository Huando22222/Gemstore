import 'package:get/get.dart';
import 'package:mevivu_task2/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService currentUserService = Get.find<AuthService>();

  ////need ??
  // void loginUser({required String username, required String password}) {
  //   currentUserService.loginUser(username: username, password: password);
  // }
}
