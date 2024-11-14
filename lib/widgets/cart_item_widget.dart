import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/controllers/cart_controller.dart';

import 'package:mevivu_task2/models/cart.dart';
import 'package:mevivu_task2/models/product.dart';
import 'package:mevivu_task2/styles/app_text_style.dart';

class CartItemWidget extends StatelessWidget {
  final Cart cartItem;
  const CartItemWidget({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final double priceAfterDiscount = cartItem.product.price *
        (1 - cartItem.product.discountPercentage / 100);

    void handleDecreaseItem(Product product) {
      cartController.cartService.decreaseQuantity(product);
    }

    void handleIncreaseItem(Product product) {
      cartController.cartService.addToCart(product);
    }

    return Container(
      height: 120,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
            child: Image.network(
              cartItem.product.images[0],
              height: 120,
              width: 120,
            ),
          ),
          SizedBox(width: 5),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: MediaQuery.of(context).size.width - 40 - 120 - 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  cartItem.product.title,
                  style: AppTextStyle.titleProduct,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          cartItem.product.price.toString(),
                          style: AppTextStyle.price,
                        ),
                        Text(
                          priceAfterDiscount.toStringAsFixed(2),
                          style: AppTextStyle.priceAfterDiscount,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: Color(0xff508a7b),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Wrap(
                              runAlignment: WrapAlignment.spaceBetween,
                              spacing: 20,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      handleDecreaseItem(cartItem.product),
                                  child: Icon(Icons.remove),
                                ),
                                InkWell(
                                  onTap: () =>
                                      handleIncreaseItem(cartItem.product),
                                  child: Text(
                                    cartItem.quantity.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () =>
                                      handleIncreaseItem(cartItem.product),
                                  child: Icon(Icons.add),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
                Text(
                  '${cartItem.product.brand}|${cartItem.product.warrantyInformation}',
                  style: AppTextStyle.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
