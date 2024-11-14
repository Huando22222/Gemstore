import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mevivu_task2/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ProductController());
  }
}
