

import 'package:demo_alor_feri/controller/product_detail_controller.dart';
import 'package:demo_alor_feri/pages/payment_page.dart';
import 'package:demo_alor_feri/value/const_image.dart';
import 'package:demo_alor_feri/value/const_string.dart';
import 'package:demo_alor_feri/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../model/boxes.dart';
import '../model/note_model.dart';
import 'cart_page.dart';
import 'home.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.stock_quantity,
    required this.url,
    this.value = false ,
  });


  String id ;
  String name ;
  int stock_quantity ;
  String url ;
  int price ;
  bool value ;

  ProductDetailsController productDetailsController = Get.put(ProductDetailsController()) ;



  CartController cartController = Get.put(CartController());



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          GestureDetector(
              onTap: (){
                Get.to(CartPage()) ;
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    Align(alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Obx(() => Text("${cartController.number.value}", style: const TextStyle(fontSize: 14))),
                        ))
                  ],
                ),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    url.isNotEmpty ? Image.network("${ConstString.serverUrl}$url") :
                        Image.asset("assets/image/blank.png"),

                    const SizedBox( height: 20,),
                    Text("Product Name: $name", style: const TextStyle(fontSize: 18),),
                    Text("Price: $price ৳",  style: const TextStyle(fontSize: 18)),
                    Text("available: $stock_quantity", style: const TextStyle(fontSize: 18)),

                    const SizedBox(height: 10),

                    Obx(() => Row(
                      children: [

                        GestureDetector(
                            onTap: (){
                              productDetailsController.decrement() ;
                            },
                            child: Image.asset(ConstImage.subtract, width: 20, height: 20,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text("${productDetailsController.value.value}"),
                        ),
                        GestureDetector(
                            onTap: (){
                              productDetailsController.increment() ;
                            },
                            child: const Icon(Icons.add_circle))
                      ],
                    ))



                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.message),
                        Text(ConstString.chat)
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      title: value ? ConstString.checkOut : ConstString.addCart,
                      horizontal: 4,
                      radius: 6,
                      onTap: (){
                        final data = NotesModel(id: id, name: name, url: url, price: price, stock_quantity: stock_quantity) ;

                        final box = Boxes.getData() ;
                        box.add(data) ;

                        print(box.length) ;
                        cartController.saveCart();


                      },


                    )
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      title: "Buy Now",
                      onTap: (){
                        Get.to(Payment( price: price, onTap: (){
                          Get.snackbar(ConstString.payment, ConstString.paymentSuccessful);

                          Get.offAll(Home()) ;
                        },));
                      },
                      color: Colors.blue,
                      horizontal: 4,
                      radius: 6,



                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
