import 'package:get/get.dart';

import '../model/boxes.dart';
import '../model/note_model.dart';

class CartController extends GetxController {
  RxInt number = 0.obs;
  RxBool value = false.obs;
  RxList isCartAdded = [].obs;
  RxInt productBuy = 1.obs;

  @override
  void onInit() {
    cartList();
    super.onInit();
  }

  increment() {
    productBuy.value = productBuy.value + 1;
  }

  decrement() {
    if (productBuy.value != 0) {
      productBuy.value = productBuy.value - 1;
    }
  }

  deleteCart(String id) async {
    var box = Boxes.getData();
    var data = box.values.toList().cast<NotesModel>();
    for (int i = 0; i < data.length; i++) {
      var aaa = data[i];
      var getId = aaa!.id;
      if (getId == id) {
        data[i].delete();
        saveCart();
      }
    }
  }

  cartList() {
    final box = Boxes.getData();
    for (int i = 0; i < box.length; i++) {
      var aaa = box.getAt(i);
      isCartAdded.add(aaa?.id);
    }
  }

  addToCart(bool newValue) {
    value.value = newValue;
  }

  saveCart() {
    number.value = Boxes.getData().length;
  }

  int setAllPrice() {
    var box = Boxes.getData();
    var data = box.values.toList().cast<NotesModel>();

    int allPrice = 0;
    int price = 0;
    int stock = 0;

    for (var item in data) {
      price = item.price;
      stock = item.stock_quantity;
      allPrice = allPrice + (price * stock);
    }

    return allPrice;
  }
}
