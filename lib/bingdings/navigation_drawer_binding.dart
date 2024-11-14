import 'package:get/get.dart';
import 'package:mevivu_task2/controllers/navigation_drawer_controller.dart';

class NavigationDrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationDrawerController());
  }
}
