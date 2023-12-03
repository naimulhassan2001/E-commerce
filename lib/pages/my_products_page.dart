
import 'package:demo_alor_feri/controller/login_controller.dart';
import 'package:demo_alor_feri/controller/my_products_controller.dart';
import 'package:demo_alor_feri/pages/product_detail_page.dart';
import 'package:demo_alor_feri/value/const_string.dart';
import 'package:demo_alor_feri/widget/my_product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../value/const_image.dart';
import '../widget/cart_item.dart';
import '../widget/product_grid_item.dart';

class MyProductsListPage extends StatelessWidget {
  MyProductsListPage({super.key});

  LogInController logInController = Get.put(LogInController());
  MyProductsController myProductsController = Get.put(MyProductsController());



  @override
  Widget build(BuildContext context) {
    myProductsController.fetchMyProductList(logInController.accessToken.value);
    return Scaffold(
        appBar: AppBar(
          title: const Text(ConstString.myProductList),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {

            _showDialog(context) ;
          },
          child: const Icon(Icons.add),
        ),
        body: Obx(() =>
        myProductsController.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: myProductsController.myProductsList.length,
          itemBuilder: (context, index) {
            var product = myProductsController.myProductsList[index];
            return GestureDetector(
              onTap: () {
                Get.to(ProductDetailPage(
                    id: product.id,
                    name: product.name,
                    price: product.price,
                    stock_quantity: product.stockQuantity,
                    url: product.url));
              },
              child: Card(
                child: Container(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            child: product.url.isNotEmpty
                                ? Image.network(
                              "${ConstString.serverUrl}${product.url}",
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
                              Text("Name: ${product.name}"),
                              const SizedBox(
                                height: 6,
                              ),
                              Text("Priice: ${product.price} \৳"),
                              Row(
                                children: [
                                  SingleChildScrollView(child: Text("${ConstString.stock}: ${product.stockQuantity} " )),
                                  const Spacer() ,
                                  GestureDetector(
                                      onTap: (){
                                        _update(context, product.id, product.name, product.price,product.stockQuantity);
                                      },
                                      child: const Icon(Icons.edit_calendar_rounded)),
                                  const SizedBox(width: 20,),
                                  GestureDetector(
                                      onTap: (){
                                        myProductsController.deleteMyProduct(logInController.accessToken.value, product.id) ;
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
              ),
            );
          },
        )
        ));


  }



  Future<void> _showDialog(BuildContext context) async{

    myProductsController.namecontroller.clear();
    myProductsController.pricecontroller.clear();
    myProductsController.stockcontroller.clear();


    return showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title:  const Text(ConstString.addProduct),
          content:  SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: myProductsController.namecontroller,
                  decoration: InputDecoration(
                      labelText: ConstString.productName,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: myProductsController.pricecontroller,
                  decoration: InputDecoration(
                      labelText: ConstString.price,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: myProductsController.stockcontroller,
                  decoration: InputDecoration(
                      labelText: ConstString.stock,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context) ;
            },
                child: const Text(ConstString.canecl)),
            TextButton(onPressed: () {
              myProductsController.addMyProduct(logInController.accessToken.value ) ;
              Navigator.pop(context) ;
            },
                child: const Text(ConstString.add)),
          ],
        );
      },) ;




  }



  Future<void> _update(BuildContext context, String id, String name, int price, int stock) async{

    myProductsController.namecontroller.text = name ;
    myProductsController.pricecontroller.text = price.toString() ;
    myProductsController.stockcontroller.text = stock.toString() ;

    return showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title:  const Text(ConstString.updateProduct),
          content:  SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: myProductsController.namecontroller,
                  decoration: InputDecoration(
                      labelText: ConstString.productName,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: myProductsController.pricecontroller,
                  decoration: InputDecoration(
                      labelText: ConstString.price,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: myProductsController.stockcontroller,
                  decoration: InputDecoration(
                      labelText: ConstString.stock,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context) ;
            },
                child: const Text(ConstString.canecl)),
            TextButton(onPressed: () {
              myProductsController.updateMyProduct(logInController.accessToken.value, id ) ;
              Navigator.pop(context) ;
            },
                child: const Text(ConstString.update)),
          ],
        );
      },) ;




  }







}
