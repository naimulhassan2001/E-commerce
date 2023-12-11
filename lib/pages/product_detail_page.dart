import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_market/controller/product_list_controller.dart';
import 'package:super_market/pages/payment_page.dart';
import '../controller/cart_controller.dart';
import '../controller/product_detail_controller.dart';
import '../model/boxes.dart';
import '../model/note_model.dart';
import '../value/const_image.dart';
import '../value/const_string.dart';
import '../widget/custom_button.dart';
import '../widget/product_details_grid_item.dart';
import '../widget/product_grid_item.dart';
import 'cart_page.dart';
import 'home.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.stockQuantity,
    required this.url,
    this.value = false,
  });

  String id;

  String name;
  int stockQuantity;

  String url;

  int price;

  bool value;

  ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());

  CartController cartController = Get.put(CartController());

  ProductListController productListController =
      Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    productDetailsController.quantity.value = 1;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(CartPage());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Obx(() => Text(
                              "${cartController.number.value}",
                              style: const TextStyle(fontSize: 14))),
                        ))
                  ],
                ),
              )),
        ],
      ),
      body: Obx(() => Padding(
            padding: EdgeInsets.all(productDetailsController.number.value),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: height * .4,
                            child: url.isNotEmpty
                                ? Image.network("${ConstString.serverUrl}$url")
                                : Image.asset(ConstImage.blank),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("৳ $price ",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.black38,
                              height: 60,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ConstString.seller,
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                        SizedBox(height: 6),
                                        Text("In House Brands")
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.message)),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text(ConstString.quantity),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                    onPressed: () {
                                      productDetailsController.decrement();
                                    },
                                    icon: const Icon(Icons.remove)),
                                const SizedBox(
                                  width: 16,
                                ),
                                Obx(
                                  () => Text(
                                      "${productDetailsController.quantity.value}"),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                IconButton(
                                    onPressed: () {
                                      productDetailsController.increment();
                                    },
                                    icon: const Icon(Icons.add)),
                                const SizedBox(width: 30),
                                Text("${ConstString.available}: $stockQuantity",
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(ConstString.total),
                                const SizedBox(
                                  width: 60,
                                ),
                                Obx(() => Text(
                                      "৳ ${price * productDetailsController.quantity.value}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              color: Colors.black26,
                              height: 2,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              ConstString.description,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            const Text("Description details"),
                            const SizedBox(height: 20),
                            const Row(
                              children: [
                                Text(ConstString.reviews),
                                Spacer(),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              children: [
                                Text(ConstString.support),
                                Spacer(),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                                height: 200,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          mainAxisExtent: 120),
                                  itemBuilder: (context, index) {
                                    Random random = Random();
                                    int randomNumber = random.nextInt(
                                        productListController
                                            .productsList.length);

                                    var product = productListController
                                        .productsList[randomNumber];
                                    return GestureDetector(
                                      onTap: () {
                                        if (productDetailsController
                                                .number.value ==
                                            16) {
                                          productDetailsController
                                              .number.value = 15.9;
                                        } else {
                                          productDetailsController
                                              .number.value = 16;
                                        }

                                        id = product.id;
                                        name = product.name;
                                        price = product.price;
                                        stockQuantity = product.stockQuantity;
                                        url = product.url;
                                      },
                                      child: ProductDetailsGridItem(
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.message),
                            Text(ConstString.chat)
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Obx(() => CustomButton(
                                title: cartController.isCartAdded.contains(id)
                                    ? ConstString.checkOut
                                    : ConstString.addCart,
                                horizontal: 4,
                                radius: 6,
                                onTap: () {
                                  if (cartController.isCartAdded.contains(id)) {
                                    buyNow();
                                  } else {
                                    addToCart();
                                  }
                                },
                              ))),
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          title: ConstString.buyNow,
                          onTap: buyNow,
                          color: Colors.blue,
                          horizontal: 4,
                          radius: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> addToCart() async {
    final data = NotesModel(
        id: id,
        name: name,
        url: url,
        price: price,
        stock_quantity: productDetailsController.quantity.value);
    final box = Boxes.getData();

    cartController.isCartAdded.value = [];
    for (int i = 0; i < box.length; i++) {
      var aaa = box.getAt(i);
      cartController.isCartAdded.add(aaa?.id);
    }

    if (cartController.isCartAdded.contains(id)) {
    } else {
      box.add(data);
      cartController.isCartAdded.add(id);
      cartController.saveCart();
    }
  }

  Future<void> buyNow() async {
    Get.to(Payment(
      price: price * productDetailsController.quantity.value,
      onTap: () {
        Get.snackbar(ConstString.payment, ConstString.paymentSuccessful);

        Get.offAll(Home());
        cartController.isCartAdded.remove(id);
        cartController.deleteCart(id);
      },
    ));
  }
}
