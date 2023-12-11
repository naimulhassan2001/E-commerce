import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_market/pages/cart_page.dart';
import 'package:super_market/pages/login_page.dart';
import 'package:super_market/pages/products_list_page.dart';
import 'package:super_market/pages/profile_page.dart';
import 'package:super_market/pages/test_page.dart';
import '../controller/cart_controller.dart';
import '../controller/login_controller.dart';
import '../controller/product_list_controller.dart';
import '../value/const_string.dart';
import '../widget/nav_bar.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final ProductListController productListController =
      Get.put(ProductListController());

  CartController cartController = Get.put(CartController());
  LogInController logInController = Get.put(LogInController());

  List pages = [ProductsListPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    cartController.saveCart();
    return Scaffold(
      bottomNavigationBar: Obx(() => CurvedNavigationBar(
              index: productListController.indexNumber.value,
              height: 60,
              onTap: (index) {
                productListController.indexNumber.value = index;
                if (productListController.value.value != 0) {
                  productListController.value.value = 0;
                }
              },
              color: Colors.blue,
              buttonBackgroundColor: Colors.blue,
              backgroundColor: Colors.white,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 800),
              items: [
                Column(
                  children: [
                    Obx(
                      () => Center(
                        child: productListController.indexNumber.value == 0
                            ? const SizedBox(
                                height: 2,
                              )
                            : const SizedBox(
                                height: 20,
                              ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.home,
                        size: 24,
                      ),
                    ),
                    const Text(ConstString.home,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  children: [
                    Obx(
                      () => Center(
                        child: productListController.indexNumber.value == 1
                            ? const SizedBox(
                                height: 2,
                              )
                            : const SizedBox(
                                height: 20,
                              ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.person,
                        size: 24,
                      ),
                    ),
                    const Text(ConstString.profile,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ])),
      appBar: AppBar(
        title: const Text(ConstString.appName),
        actions: [
          GestureDetector(
              onTap: () {
                if (logInController.isLogIn.value) {
                  Get.to(CartPage());
                } else {
                  Get.to(LogInPage());
                }
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
        leading: GestureDetector(
            onTap: () {
              if (productListController.value.value == 0) {
                productListController.value.value = 1;
              } else {
                productListController.value.value = 0;
              }
            },
            child: const Icon(Icons.menu)),
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue[400]!,
            Colors.blue[800]!,
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        ),
        NavBar(),
        Obx(() => TweenAnimationBuilder(
            tween:
                Tween<double>(begin: 0, end: productListController.value.value),
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 500),
            builder: (context, val, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val)
                  ..rotateY((pi / 6) * val),
                child:
                    Obx(() => pages[productListController.indexNumber.value]),
              );
            })),
        GestureDetector(
          onHorizontalDragUpdate: (e) {
            if (e.delta.dx > 0) {
              productListController.value.value = 1;
            } else {
              productListController.value.value = 0;
            }
          },
        )
      ]),
    );
  }
}
