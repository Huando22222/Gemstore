import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/controllers/cart_controller.dart';
import 'package:mevivu_task2/controllers/product_controller.dart';
import 'package:mevivu_task2/models/product.dart';
import 'package:mevivu_task2/routes/app_routes.dart';
import 'package:mevivu_task2/widgets/card_widget.dart';
import 'package:mevivu_task2/widgets/custom_navigation_drawer_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String showCategory = 'beauty';
  bool showAll = false;
  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final Map<String, String> categoryMap = {
    'beauty': 'images/beauty.png',
    'fragrances': 'images/fragrances.png',
    'furniture': 'images/furniture.png',
    'groceries': 'images/groceries.png',
  };
  void handleShowCategory(String title) {
    setState(() {
      showCategory = title;
      debugPrint('title --------> $showCategory');
    });
  }

  void handleShowAll() {
    setState(() {
      showAll = !showAll;
    });
  }

  void handleProductDetail(Product product) {
    Get.toNamed(AppRoutes.productDetail, arguments: product);
  }

  void handlePressCart() {
    Get.toNamed(AppRoutes.cart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Gemstore",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: handlePressCart,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'images/bag.png',
                    height: 30,
                  ),
                  Positioned(
                    right: -10,
                    top: -10,
                    child: Obx(
                      () {
                        return Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffD32F2F)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cartController.cartService.cartItems.value.length
                                  .toString(),
                              style: TextStyle(
                                color: Color(0xffFFEB3B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      drawer: CustomNavigationDrawerWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Obx(
                () {
                  if (productController.isLoading.value) {
                    return CircularProgressIndicator();
                  }
                  final categories =
                      productController.productList.map((product) {
                    debugPrint('${product.category} ->');
                    return product.category;
                  }).toSet();

                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 100,
                      minWidth: MediaQuery.of(context).size.width,
                      maxHeight: 120,
                    ),
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return buildCategory(
                          title: categories.elementAt(index),
                          isSelected:
                              categories.elementAt(index) == showCategory,
                          onTap: () => handleShowCategory(
                            categories.elementAt(index),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 30);
                      },
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                },
              ),
              buildSearchBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory({
    required bool isSelected,
    required String title,
    required VoidCallback onTap,
  }) {
    final imagePath = categoryMap[title];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Color(0xff3a2c27) : Colors.transparent,
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xff3a2c27) : Color(0xfff3f3f3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: imagePath != null
                      ? Image.asset(
                          imagePath,
                          color: isSelected ? Colors.white : Color(0xffa2a2a2),
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        )
                      : SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? Color(0xff3a2c27) : Color(0xffa2a2a2),
          ),
        ),
      ],
    );
  }

  Widget buildSearchBody() {
    return Obx(() {
      if (productController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final matchingProducts = productController.productList
          .where((product) => product.category == showCategory)
          .toList();

      if (matchingProducts.isNotEmpty) {
        final displayProducts = matchingProducts.take(3).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                    ),
                    items: displayProducts.map((product) {
                      return InkWell(
                        onTap: () {
                          handleProductDetail(product);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.red.shade300,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              product.images[0],
                              width: double.infinity,
                              height: double.infinity,
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Feature Products'),
                  InkWell(
                    onTap: () => handleShowAll(),
                    child: Text(
                      showAll ? 'Show less' : 'Show all',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!showAll)
              ConstrainedBox(
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
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 16,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: matchingProducts.length,
                itemBuilder: (context, index) {
                  return CardWidget(
                    product: matchingProducts[index],
                    onTap: () => handleProductDetail(
                      matchingProducts[index],
                    ),
                  );
                },
              ),
          ],
        );
      } else {
        return Center(
          child: Text('No products found in this category.'),
        );
      }
    });
  }
}
