

import 'package:demo_alor_feri/model/boxes.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class CartController extends GetxController {



  RxInt number = 0.obs ;
  RxBool value = false.obs ;




  addToCart(bool newValue) {
    value.value = newValue ;
  }

  saveCart() {
    number.value = Boxes.getData().length ;
  }


  getCartItem() {




  }







}