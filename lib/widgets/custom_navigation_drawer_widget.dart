import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/controllers/auth_controller.dart';
import 'package:mevivu_task2/controllers/cart_controller.dart';
import 'package:mevivu_task2/controllers/navigation_drawer_controller.dart';
import 'package:mevivu_task2/routes/app_routes.dart';

class CustomNavigationDrawerWidget extends StatelessWidget {
  const CustomNavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(NavigationDrawerController());
    final NavigationDrawerController navigationDrawerController =
        Get.find<NavigationDrawerController>();

    // Get.put(AuthController());
    final AuthController currentUserController = Get.find<AuthController>();

    final Map<String, dynamic> listTab = navigationDrawerController.listTab;
    double statusbarHeight = MediaQuery.of(context).padding.top;
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, top: 20 + statusbarHeight),
            child:
                //
                Obx(
              () {
                final currentUser =
                    currentUserController.currentUserService.currentUser.value;
                return InkWell(
                  onTap: () {
                    if (currentUser == null) {
                      Get.toNamed(AppRoutes.login);
                    } else {
                      Get.toNamed(AppRoutes.profile);
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                        color: Colors.amber,
                        width: 4,
                      ),
                    ),
                    child: Image.network(
                      currentUser?.image ??
                          "https://cdn-icons-png.flaticon.com/512/4515/4515630.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: listTab.length,
              itemBuilder: (context, index) {
                String title = listTab.keys.elementAt(index);
                Widget icon = listTab[title];
                return Obx(
                  () {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 5,
                      ),
                      child: buildItem(
                        context: context,
                        navigationDrawerController: navigationDrawerController,
                        title: title,
                        icon: icon,
                        isSelected:
                            // title == navigationDrawerController.onTab.value,
                            title ==
                                navigationDrawerController
                                    .navigationDrawerService.onTab.value,
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                if (index == 3) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20,
                    ),
                    child: Text("OTHER"),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    required BuildContext context,
    required String title,
    required Widget icon,
    required NavigationDrawerController navigationDrawerController,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[300] : Colors.transparent,
      ),
      child: ListTile(
        leading: icon,
        title: Text(title),
        onTap: () {
          navigationDrawerController.changeTab(title);
        },
      ),
    );
  }
}
