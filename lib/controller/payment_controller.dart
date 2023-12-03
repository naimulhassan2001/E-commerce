
import 'package:get/get.dart';

class PaymentController extends GetxController {

  RxBool bkash = false.obs ;
  RxBool nagad = false.obs ;
  RxBool stripe = false.obs ;


  valueBkash(value) {
    bkash.value = value ;

    if(value== true) {
      nagad.value = false ;
      stripe.value = false ;
    }
  }

  valueNagad(value) {
    nagad.value = value ;

    if(value== true) {
      bkash.value = false ;
      stripe.value = false ;
    }
  }


  valueStripe(value) {
    stripe.value = value ;

    if(value== true) {
      bkash.value = false ;
      nagad.value = false ;
    }
  }









}