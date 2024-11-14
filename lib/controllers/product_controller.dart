import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mevivu_task2/models/product.dart';
import 'package:mevivu_task2/services/api_service.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();
  var productList = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading(true);
      final res = await _apiService.get('/products');

      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        productList.assignAll(
          (data['products'] as List).map((p) => Product.fromJson(p)).toList(),
        );
      }
    } catch (e) {
      debugPrint('$e error in product controller');
    } finally {
      isLoading(false);
    }
  }
}
