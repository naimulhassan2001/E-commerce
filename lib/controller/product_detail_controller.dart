import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  RxInt quantity = 1.obs;

  RxDouble number = 16.0.obs;

  increment() {
    quantity.value = quantity.value + 1;
  }

  decrement() {
    if (quantity.value != 1) {
      quantity.value = quantity.value - 1;
    }
  }
}
