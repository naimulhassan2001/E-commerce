import 'package:demo_alor_feri/controller/product_list_controller.dart';
import 'package:demo_alor_feri/widget/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsListPage extends StatelessWidget {
  ProductsListPage({super.key});

  final ProductListController productListController =
      Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    productListController.fetchProductList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Obx(() => productListController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: productListController.productsList.length,
              itemBuilder: (context, index) {
                var user = productListController.productsList[index];
                return ProductListItem(
                  productName: user['name'],
                  price: user['price'],
                  id: user['id'],
                  index: index,
                );
              },
            )),
    );
  }
}
