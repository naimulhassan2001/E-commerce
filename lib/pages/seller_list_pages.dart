import 'package:demo_alor_feri/controller/user_list_controller.dart';
import 'package:demo_alor_feri/pages/seller_product_list.dart';
import 'package:demo_alor_feri/widget/seller_girdview_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerListPage extends StatelessWidget {
  SellerListPage({super.key});

  final SellerListController sellerListController =
      Get.put(SellerListController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body:  Obx(() => sellerListController.isLoading.value
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
        itemCount: sellerListController.sellerList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 200),
        itemBuilder: (context, index) {
          var seller = sellerListController.sellerList[index];

          return GestureDetector(
            onTap: (){
              Get.to(SellerProductList(id: seller.id, name: seller.name, url: seller.url));
            },
            child: SellerGirdViewItem(
                id: seller.id,
                name: seller.name,
                url: seller.url),
          );
        },
      )));

  }
}
