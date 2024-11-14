import 'package:get/get.dart';
import 'package:mevivu_task2/controllers/auth_controller.dart';
import 'package:mevivu_task2/controllers/cart_controller.dart';
import 'package:mevivu_task2/services/auth_service.dart';
import 'package:mevivu_task2/services/cart_service.dart';
import 'package:mevivu_task2/services/navigation_drawer_service.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NavigationDrawerService());
    Get.put(AuthService());
    Get.put(CartService());
    Get.put(CartController());
    Get.put(AuthController());
  }
}
