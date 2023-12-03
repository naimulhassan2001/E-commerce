


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/my_products_controller.dart';
import '../value/const_image.dart';
import '../value/const_string.dart';

class MyProductListItem extends StatelessWidget {
  MyProductListItem({
    super.key,
    required this.id,
    required this.name,
    required this.url,
    required this.price,
    required this.stock,
    required this.token,

  });


  String id;
  String name;
  String url;
  int price;
  int stock;
  String token ;

  MyProductsController myProductsController = Get.put(MyProductsController()) ;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                  child: url.isNotEmpty
                      ? Image.network(
                    "${ConstString.serverUrl}$url",
                    fit: BoxFit.cover,
                  )
                      : Image.asset(ConstImage.blank)),
            ),
            Expanded (
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 6,
                    ),
                    Text("Name: $name"),
                    const SizedBox(
                      height: 6,
                    ),
                    Text("Priice: $price \৳"),
                    Row(
                      children: [
                        SingleChildScrollView(child: Text("${ConstString.stock}: $stock " )),
                        const Spacer() ,
                        GestureDetector(
                          onTap: (){},
                            child: const Icon(Icons.edit_calendar_rounded)),
                        const SizedBox(width: 20,),
                        GestureDetector(
                          onTap: (){
                            myProductsController.deleteMyProduct(token, id) ;
                          },
                            child: const Icon(Icons.delete))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );;
  }
}
