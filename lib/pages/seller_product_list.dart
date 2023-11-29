

import 'package:demo_alor_feri/controller/seller_product_list.dart';
import 'package:demo_alor_feri/pages/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/product_grid_item.dart';

class SellerProductList extends StatelessWidget {
  SellerProductList({
    super.key,
    required this.id,
    required this.name,
    required this.url

  });

  String id ;
  String name ;
  String url ;



  SellerProductController sellerProductController = Get.put(SellerProductController());

  @override
  Widget build(BuildContext context) {

    sellerProductController.fetchSellerProduct(id);
    return Scaffold(
      appBar: AppBar(title: Text("Seller $name"),),
      body: Obx(() => sellerProductController.isLoading.value
          ? const Center(
        child: CircularProgressIndicator(),
      )
          :GridView.builder(
        itemCount: sellerProductController.sellerProductList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 250
        ),
        itemBuilder: (context, index) {
          var product = sellerProductController.sellerProductList[index];
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
      )),
    );
  }
}
