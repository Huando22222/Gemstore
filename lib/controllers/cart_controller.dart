import 'package:get/get.dart';
import 'package:mevivu_task2/models/cart.dart';
import 'package:mevivu_task2/services/cart_service.dart';

class CartController extends GetxController {
  final CartService cartService = Get.find<CartService>();

  List<Cart> get cartItems => cartService.cartItems;
  RxInt get totalItems => cartService.totalItems;
  RxDouble get totalAmount => cartService.totalAmount;
}
