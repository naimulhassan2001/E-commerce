

import 'package:demo_alor_feri/pages/payment_page.dart';
import 'package:demo_alor_feri/value/const_string.dart';
import 'package:demo_alor_feri/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../model/boxes.dart';
import '../model/note_model.dart';

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


  CartController hiveController = Get.put(CartController());



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    return Scaffold(
      appBar: AppBar(title: Text(name),),
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
                        hiveController.saveCart();


                      },


                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                      title: "Buy Now",
                      onTap: (){
                        Get.to(Payment( price: price));
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
