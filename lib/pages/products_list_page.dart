import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_market/pages/product_detail_page.dart';
import '../controller/cart_controller.dart';
import '../controller/product_list_controller.dart';
import '../value/const_string.dart';
import '../widget/product_grid_item.dart';

class ProductsListPage extends StatelessWidget {
  ProductsListPage({super.key});

  final ProductListController productListController =
      Get.put(ProductListController());

  CartController hiveController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    hiveController.saveCart();
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 42,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    labelText: ConstString.search,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4))),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // CarouselSlider(
                //     items: [
                //       Container(
                //         height: 150,
                //         margin: const EdgeInsets.symmetric(horizontal: 8),
                //         decoration: const BoxDecoration(
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(25))),
                //         child: Image.asset(
                //           ConstImage.slider_5,
                //           fit: BoxFit.fill,
                //           isAntiAlias: true,
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         decoration: const BoxDecoration(
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(100))),
                //         child: Image.asset(
                //           ConstImage.slider_2,
                //           fit: BoxFit.fill,
                //           isAntiAlias: true,
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         decoration: const BoxDecoration(
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(50))),
                //         child: Image.asset(
                //           ConstImage.slider_4,
                //         ),
                //       ),
                //     ],
                //     options: CarouselOptions(
                //         height: 120,
                //         aspectRatio: 16 / 9,
                //         autoPlay: true,
                //         autoPlayAnimationDuration: const Duration(seconds: 3),
                //         enlargeCenterPage: true)),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        ConstString.allProducts,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => productListController.productsList.isEmpty
                    ? const CircularProgressIndicator()
                    : Expanded(
                        child: Center(
                          child: Obx(
                              () => productListController.productsList.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : GridView.builder(
                                      controller: productListController
                                          .scrollController,
                                      itemCount:
                                          productListController.isLoading.value
                                              ? productListController
                                                      .productsList.length +
                                                  1
                                              : productListController
                                                  .productsList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisExtent: 300),
                                      itemBuilder: (context, index) {
                                        if (index <
                                            productListController
                                                .productsList.length) {
                                          var product = productListController
                                              .productsList[index];
                                          return GestureDetector(
                                            onTap: () {
                                              Get.to(ProductDetailPage(
                                                id: product.id,
                                                name: product.name,
                                                price: product.price,
                                                stockQuantity:
                                                    product.stockQuantity,
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
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    )),
                        ),
                      ))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
