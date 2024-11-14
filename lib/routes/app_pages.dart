import 'package:get/get.dart';
import 'package:mevivu_task2/bingdings/navigation_drawer_binding.dart';
import 'package:mevivu_task2/bingdings/product_binding.dart';
import 'package:mevivu_task2/routes/app_routes.dart';
import 'package:mevivu_task2/screens/about_screen.dart';
import 'package:mevivu_task2/screens/cart_screen.dart';
import 'package:mevivu_task2/screens/discover_screen.dart';
import 'package:mevivu_task2/screens/home_page_screen.dart';
import 'package:mevivu_task2/screens/login_screen.dart';
import 'package:mevivu_task2/screens/my_order_screen.dart';
import 'package:mevivu_task2/screens/product_detail_screen.dart';
import 'package:mevivu_task2/screens/profile_screen.dart';
import 'package:mevivu_task2/screens/setting_screen.dart';
import 'package:mevivu_task2/screens/support_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePageScreen(),
      bindings: [
        NavigationDrawerBinding(),
        ProductBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.discover,
      page: () => DiscoverScreen(),
    ),
    GetPage(
      name: AppRoutes.myOrder,
      page: () => MyOrderScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.setting,
      page: () => SettingScreen(),
    ),
    GetPage(
      name: AppRoutes.support,
      page: () => SupportScreen(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => AboutScreen(),
    ),
    //
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => CartScreen(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => ProductDetailScreen(),
    ),
  ];
}
