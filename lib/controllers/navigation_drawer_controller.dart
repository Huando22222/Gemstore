import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/services/navigation_drawer_service.dart';

class NavigationDrawerController extends GetxController {
  final NavigationDrawerService navigationDrawerService =
      Get.find<NavigationDrawerService>();
  // RxString get onTab => navigationDrawerService.onTab; //need?

  Map<String, dynamic> get listTab => navigationDrawerService.listTab;

  Map<String, String> get tabRoutes => navigationDrawerService.tabRoutes;

  @override
  void onInit() {
    super.onInit();
    changeTab(navigationDrawerService.listTab.keys.first);
  }

  void changeTab(String tab) {
    navigationDrawerService.changeTab(tab);
    final route = navigationDrawerService.getRoute(tab);
    if (route != null) {
      debugPrint("Navigating to: $route");
      Get.toNamed(route);
    }
  }
}
