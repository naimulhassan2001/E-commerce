

import 'package:demo_alor_feri/controller/login_controller.dart';
import 'package:demo_alor_feri/controller/my_products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/product_list_item.dart';

class MyProductsList extends StatelessWidget {
  MyProductsList({super.key});
  LogInController logInController = Get.put(LogInController()) ;

  MyProductsController myProductsController = Get.put(MyProductsController()) ;

  @override
  Widget build(BuildContext context) {
    myProductsController.fetchMyProductList(logInController.access_token.value) ;
    print(logInController.access_token.value) ;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Obx(() => myProductsController.isLoading.value
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: myProductsController.myProductsList.length,
        itemBuilder: (context, index) {
          var user = myProductsController.myProductsList[index];
          return ProductListItem(
            productName: user['name'],
            price: user['price'],
            ownerName: user['user']['name'],
            id: user['id'],
            index: index,
          );
        },
      )),
    );
  }
}
