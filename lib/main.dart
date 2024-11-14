import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mevivu_task2/bingdings/root_binding.dart';
import 'package:mevivu_task2/controllers/auth_controller.dart';
import 'package:mevivu_task2/controllers/cart_controller.dart';
import 'package:mevivu_task2/routes/app_pages.dart';
import 'package:mevivu_task2/routes/app_routes.dart';
import 'package:mevivu_task2/services/auth_service.dart';
import 'package:mevivu_task2/services/cart_service.dart';
import 'package:mevivu_task2/services/navigation_drawer_service.dart';

void main() async {
  await GetStorage.init();
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homePage,
      getPages: AppPages.routes,
      initialBinding: RootBinding(),
    );
  }
}
