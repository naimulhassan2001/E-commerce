

import 'package:get/get.dart';

class ProductDetailsController extends GetxController {


  RxInt value = 1.obs ;




  increment() {

    value.value = value.value +1 ;
  }
  decrement() {

    if(value.value !=0) {
      value.value = value.value -1 ;

    }
  }



}