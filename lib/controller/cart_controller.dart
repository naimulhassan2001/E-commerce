

import 'package:demo_alor_feri/model/boxes.dart';
import 'package:get/get.dart';

import '../model/note_model.dart';

class CartController extends GetxController {



  RxInt number = 0.obs ;
  RxBool value = false.obs ;



  addToCart(bool newValue) {
    value.value = newValue ;
  }

  saveCart() {
    number.value = Boxes.getData().length ;
  }


  int setAllPrice() {

    var box = Boxes.getData() ;
    var data = box.values.toList().cast<NotesModel>();
    int allPrice = 0;

    for(var item in data ) {
      allPrice = allPrice + item.price ;
    }


    return  allPrice;

  }









}