import 'package:demo_alor_feri/controller/login_controller.dart';
import 'package:demo_alor_feri/controller/my_products_controller.dart';
import 'package:demo_alor_feri/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: const Text('My Product List'),
      ),
      body: Obx(() => myProductsController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          :GridView.builder(
        itemCount: myProductsController.myProductsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 250
        ),
        itemBuilder: (context, index) {
          var product =
          myProductsController.myProductsList[index];
          return GestureDetector(
            onTap: () {
              Get.to(ProductDetailPage(
                  id: product.id,
                  name: product.name,
                  price: product.price,
                  stock_quantity: product.stockQuantity,
                  url: product.url

              ));
            },
            child: ProductGridItem(
              productName: product.name,
              price: product.price,
              id: product.id,
              index: index,
              url: product.url,
              stock: product.stockQuantity,
            ),
          );
        },
      ))
    ) ;
  }
}
