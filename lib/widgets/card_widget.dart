// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mevivu_task2/models/product.dart';
import 'package:mevivu_task2/styles/app_text_style.dart';

class CardWidget extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const CardWidget({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double priceAfterDiscount =
        product.price * (1 - product.discountPercentage / 100);
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Image.network(
                  product.images[0],
                  height: 200,
                  width: 150,
                ),
              ),
              Positioned(
                right: -5,
                top: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '-${product.discountPercentage.toStringAsFixed(1)}%'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          SizedBox(
            width: 150,
            child: Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Text(
            '\$${product.price}',
            style: AppTextStyle.price,
          ),
          SizedBox(
            width: 150,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${priceAfterDiscount.toStringAsFixed(2)}',
                  style: AppTextStyle.priceAfterDiscount,
                ),
                Text('stock:${product.stock}'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
