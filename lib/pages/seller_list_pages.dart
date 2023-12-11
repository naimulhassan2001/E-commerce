import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_market/pages/seller_product_list.dart';

import '../controller/seller_list_controller.dart';
import '../widget/seller_girdview_item.dart';

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
        body: Obx(() => sellerListController.sellerList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                controller: sellerListController.scrollController,
                itemCount: sellerListController.isLoadingMore.value
                    ? sellerListController.sellerList.length + 1
                    : sellerListController.sellerList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisExtent: 200),
                itemBuilder: (context, index) {
                  if (index < sellerListController.sellerList.length) {
                    var seller = sellerListController.sellerList[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(SellerProductList(
                            id: seller.id, name: seller.name, url: seller.url));
                      },
                      child: SellerGirdViewItem(
                          id: seller.id, name: seller.name, url: seller.url),
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                },
              )));
  }
}
