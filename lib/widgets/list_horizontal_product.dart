import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/models/product.dart';
import 'package:mevivu_task2/routes/app_routes.dart';
import 'package:mevivu_task2/widgets/card_widget.dart';

class ListHorizontalProduct extends StatelessWidget {
  final List<Product> matchingProducts;
  const ListHorizontalProduct({
    super.key,
    required this.matchingProducts,
  });

  void handleProductDetail(Product product) {
    Get.toNamed(AppRoutes.productDetail, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 200,
        minWidth: MediaQuery.of(context).size.width,
        maxHeight: 300,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CardWidget(
            product: matchingProducts[index],
            onTap: () => handleProductDetail(matchingProducts[index]),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 20);
        },
        itemCount: matchingProducts.length,
      ),
    );
  }
}
