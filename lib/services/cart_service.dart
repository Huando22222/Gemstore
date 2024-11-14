import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mevivu_task2/models/cart.dart';
import 'package:mevivu_task2/models/product.dart';

class CartService extends GetxService {
  final box = GetStorage();
  var cartItems = <Cart>[].obs;
  final RxInt totalItems = 0.obs;
  final RxDouble totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage();
    // Update totals whenever cart changes
    ever(cartItems, (_) {
      _updateTotals();
      _saveCartToStorage();
    });
  }

  void loadCartFromStorage() {
    try {
      final cartData = box.read('cart');
      if (cartData != null) {
        final List<dynamic> cartList = cartData;
        cartItems.value = cartList.map((item) => Cart.fromJson(item)).toList();
        _updateTotals();
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
    }
  }

  void _saveCartToStorage() {
    try {
      final cartData = cartItems.map((item) => item.toJson()).toList();
      box.write('cart', cartData);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  void _updateTotals() {
    totalItems.value = cartItems.fold(0, (sum, item) => sum + item.quantity);
    totalAmount.value = cartItems.fold(0.0,
        (sum, item) => sum + (item.quantity * (item.product.price ?? 0.0)));
  }

  void addToCart(Product product) {
    try {
      final existingItemIndex =
          cartItems.indexWhere((item) => item.product.id == product.id);
      Get.snackbar("Thành công", "Thêm sản phẩm vào giỏ hàng");
      if (existingItemIndex >= 0) {
        // Product already exists in cart, increment quantity
        cartItems[existingItemIndex].quantity++;
        cartItems.refresh();
      } else {
        // Add new product to cart

        cartItems.add(Cart(product: product, quantity: 1));
      }
    } catch (e) {
      debugPrint('Error adding to cart: $e');
      Get.snackbar(
        'Error',
        'Failed to add item to cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void decreaseQuantity(Product product) {
    try {
      final existingItemIndex =
          cartItems.indexWhere((item) => item.product.id == product.id);

      if (existingItemIndex >= 0) {
        if (cartItems[existingItemIndex].quantity > 1) {
          cartItems[existingItemIndex].quantity--;
          cartItems.refresh();
        } else {
          removeFromCart(product);
        }
      }
    } catch (e) {
      debugPrint('Error decreasing quantity: $e');
      Get.snackbar(
        'Error',
        'Failed to decrease quantity',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeFromCart(Product product) {
    try {
      cartItems.removeWhere((item) => item.product.id == product.id);
      Get.snackbar(
        'Success',
        'Item removed from cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint('Error removing from cart: $e');
      Get.snackbar(
        'Error',
        'Failed to remove item from cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void clearCart() {
    try {
      cartItems.clear();
      Get.snackbar(
        'Success',
        'Cart cleared',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint('Error clearing cart: $e');
      Get.snackbar(
        'Error',
        'Failed to clear cart',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Get quantity of specific product in cart
  int getProductQuantity(Product product) {
    final cartItem = cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => Cart(product: product, quantity: 0),
    );
    return cartItem.quantity;
  }
}
