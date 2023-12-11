import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_market/pages/product_detail_page.dart';
import 'package:super_market/value/const_string.dart';

import '../controller/seller_product_list.dart';
import '../widget/product_grid_item.dart';

class SellerProductList extends StatelessWidget {
  SellerProductList(
      {super.key, required this.id, required this.name, required this.url});

  String id;

  String name;

  String url;

  SellerProductController sellerProductController =
      Get.put(SellerProductController());

  @override
  Widget build(BuildContext context) {
    sellerProductController.fetchSellerProduct(id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Seller $name"),
      ),
      body: Obx(() => sellerProductController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: sellerProductController.sellerProductList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 300),
              itemBuilder: (context, index) {
                var product = sellerProductController.sellerProductList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(ProductDetailPage(
                      id: product.id,
                      name: product.name,
                      price: product.price,
                      stockQuantity: product.stockQuantity,
                      url: product.url,
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
            )),
    );
  }
}
