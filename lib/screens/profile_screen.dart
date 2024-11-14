import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/controllers/auth_controller.dart';
import 'package:mevivu_task2/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
        onPressed: () {
          authController.currentUserService.logout();
        },
        child: Text("Logout"),
      ),
    );
  }
}
