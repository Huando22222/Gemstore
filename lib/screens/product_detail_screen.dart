import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/controllers/cart_controller.dart';
import 'package:mevivu_task2/models/product.dart';
import 'package:mevivu_task2/styles/app_text_style.dart';
import 'package:mevivu_task2/widgets/rating_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isShowDescription = true;
  bool isShowReviews = true;
  final CartController cartController = Get.find<CartController>();

  void showDescription() {
    setState(() {
      isShowDescription = !isShowDescription;
    });
  }

  void showReviews() {
    setState(() {
      isShowReviews = !isShowReviews;
    });
  }

  void handleAddToCart(Product product) {
    cartController.cartService.addToCart(product);
  }

  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments;
    final double priceAfterDiscount =
        product.price * (1 - product.discountPercentage / 100);
    final double hightCartTag = 70;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 250,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 10),
                        ),
                        items: product.images.map((item) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 253, 180, 171)),
                            child: Image.network(
                              item,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          );
                        }).toList(),
                      ),
                      Positioned(
                        left: 0,
                        top: 230,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                                height: 500,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: AppTextStyle.titleProduct,
                                ),
                                Row(
                                  children: [
                                    RatingWidget(
                                      rating: product.rating,
                                    ),
                                    Text('(${product.reviews.length})'),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: AppTextStyle.price,
                                ),
                                Text(
                                  '\$${priceAfterDiscount.toStringAsFixed(2)}',
                                  style: AppTextStyle.priceAfterDiscount,
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => showDescription(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Description',
                                  style: AppTextStyle.title1,
                                ),
                                Icon(Icons.arrow_drop_down_outlined),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        if (isShowDescription)
                          Text(
                            product.description,
                            style: AppTextStyle.description,
                          ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () => showReviews(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Riviews',
                                  style: AppTextStyle.title1,
                                ),
                                Icon(Icons.arrow_drop_down_outlined),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                        if (isShowReviews)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: product.rating.toStringAsFixed(1),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '  OUT OF 5',
                                          style: AppTextStyle.description,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RatingWidget(
                                        rating: product.rating,
                                      ),
                                      Text(
                                        '${product.reviews.length} ratings',
                                        style: AppTextStyle.description,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              RatingWidget(
                                rating: product.rating,
                                reviews: product.reviews,
                                showDetail: true,
                                hideStarWidget: true,
                              ),
                              SizedBox(height: hightCartTag),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: hightCartTag),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                height: 50,
                width: 50,
                child: Icon(Icons.arrow_back_ios_outlined),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                height: 50,
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'images/heart.png',
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: InkWell(
              onTap: () => handleAddToCart(product),
              child: Container(
                height: hightCartTag,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xff343434),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        'images/bag.png',
                        color: Colors.white,
                        height: 35,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Add To Cart",
                        style: AppTextStyle.cartText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
