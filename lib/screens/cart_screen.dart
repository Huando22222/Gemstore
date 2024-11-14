import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/controllers/cart_controller.dart';
import 'package:mevivu_task2/controllers/navigation_drawer_controller.dart';
import 'package:mevivu_task2/styles/app_text_style.dart';
import 'package:mevivu_task2/widgets/cart_item_widget.dart';
import 'package:mevivu_task2/widgets/custom_navigation_drawer_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    void hanldLeading() {
      Get.back();
    }

    void handleCheckout() {
      cartController.cartService.clearCart();
    }

    final double hightBody =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final double sizedFixedCheckout = 200;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            SizedBox(
              height: hightBody,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      height: hightBody - sizedFixedCheckout - 30,
                      child: Obx(
                        () {
                          return ListView.separated(
                            itemBuilder: (context, index) {
                              return CartItemWidget(
                                cartItem:
                                    // cartController
                                    //     .cartService.cartItems.value[index],
                                    cartController.cartItems[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10);
                            },
                            itemCount: cartController.cartItems.length,
                          );
                        },
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: sizedFixedCheckout,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          blurStyle: BlurStyle.inner,
                          color: Colors.black,
                          offset: Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Product price'),
                              Obx(
                                () {
                                  return Text(
                                      '\$${cartController.totalAmount.string}');
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shipping'),
                              Text(
                                'Freeship',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style: AppTextStyle.title1,
                              ),
                              Obx(
                                () {
                                  return Text(
                                    '\$${cartController.totalAmount.string}',
                                    style: AppTextStyle.title1.copyWith(
                                      fontSize: 20,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Divider(),
                          InkWell(
                            onTap: handleCheckout,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff343434),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0,
                                  vertical: 10,
                                ),
                                child: Text('Proceed to checkout',
                                    style: AppTextStyle.cartText),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              child: InkWell(
                onTap: hanldLeading,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        blurStyle: BlurStyle.inner,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Text(
                      "Your Cart",
                      style: AppTextStyle.titleAppBar,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
