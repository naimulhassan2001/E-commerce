import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:demo_alor_feri/controller/cart_controller.dart';
import 'package:demo_alor_feri/controller/login_controller.dart';
import 'package:demo_alor_feri/pages/cart_page.dart';
import 'package:demo_alor_feri/pages/login_page.dart';
import 'package:demo_alor_feri/pages/my_products_page.dart';
import 'package:demo_alor_feri/pages/products_list_page.dart';
import 'package:demo_alor_feri/pages/profile_page.dart';
import 'package:demo_alor_feri/pages/seller_list_pages.dart';
import 'package:demo_alor_feri/value/const_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_list_controller.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final ProductListController productListController =
      Get.put(ProductListController());

  CartController cartController = Get.put(CartController());
  LogInController logInController = Get.put(LogInController());

  List pages = [ProductsListPage(), SellerListPage(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    cartController.saveCart();
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          height: 60,
          onTap: (index) {
            productListController.indexNumber.value = index;
          },
          color: Colors.blue,
          buttonBackgroundColor: Colors.blue,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 800),
          items: const [
            Column(
              children: [
                Icon(
                  Icons.home,
                  size: 24,
                ),
                Text(ConstString.home,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Icon(Icons.group),
                Text(ConstString.seller,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.person,
                  size: 24,
                ),
                Text(ConstString.profile,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          ]),
      appBar: AppBar(
        title: const Text(ConstString.appName),
        actions: [
          GestureDetector(
              onTap: () {
                if (logInController.accessToken.value.isNotEmpty) {
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
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          children: [
            ListTile(
              title: const Text("My Products"),
              leading: const Icon(Icons.shopping_bag_rounded),
              onTap: () {
                if (logInController.accessToken.value.isNotEmpty) {
                  Get.to(MyProductsListPage());

                } else{
                  Get.to(LogInPage()) ;
                }

              },
            ),
            ListTile(
              title: const Text(
                "Seller",
              ),
              leading: const Icon(
                Icons.groups,
              ),
              onTap: () {
                Get.to(SellerListPage());
              },
            ),
          ],
        ),
      ),
      body: Obx(() => pages[productListController.indexNumber.value]),
    );
  }
}
