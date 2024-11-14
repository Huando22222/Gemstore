import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/routes/app_routes.dart';

class NavigationDrawerService extends GetxService {
  var onTab = "".obs;
  //

  Map<String, dynamic> listTab = {
    'Homepage': const Icon(Icons.home_outlined),
    'Discover': const Icon(Icons.search_outlined),
    'My order': const Icon(Icons.shopify_outlined),
    'My profile': const Icon(Icons.person_outline),
    'Setting': const Icon(Icons.settings_outlined),
    'Support': const Icon(Icons.support_agent_outlined),
    'About us': const Icon(Icons.question_mark_rounded),
  };

  Map<String, String> tabRoutes = {
    'Homepage': AppRoutes.homePage,
    'Discover': AppRoutes.discover,
    'My order': AppRoutes.myOrder,
    'My profile': AppRoutes.profile,
    'Setting': AppRoutes.setting,
    'Support': AppRoutes.support,
    'About us': AppRoutes.about,
  };

  void changeTab(String tab) {
    onTab.value = tab;
  }

  String? getRoute(String tab) {
    return tabRoutes[tab];
  }
}
