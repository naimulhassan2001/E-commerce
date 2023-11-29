import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:demo_alor_feri/controller/cart_controller.dart';
import 'package:demo_alor_feri/pages/cart_page.dart';
import 'package:demo_alor_feri/pages/my_products_page.dart';
import 'package:demo_alor_feri/pages/products_list_page.dart';
import 'package:demo_alor_feri/pages/seller_list_pages.dart';
import 'package:demo_alor_feri/value/const_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/product_list_controller.dart';

class Home extends StatelessWidget {
  Home({super.key});


  final ProductListController productListController =
  Get.put(ProductListController());

  CartController hiveController = Get.put(CartController());

  List pages = [
    ProductsListPage(),
    MyProductsListPage(),
    CartPage(),
    SellerListPage(),
    ProductsListPage(),
  ] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          height: 60,
          onTap: (index){
            productListController.indexNumber.value = index ;
          },
          color: Colors.blue,
          buttonBackgroundColor: Colors.blue,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 800),
          items: [
            const Column(
              children: [
                Icon(
                  Icons.home,
                  size: 24,
                ),
                Text(ConstString.home, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.shopping_bag,
                  size: 24,
                ),
                Text(ConstString.myProducts,textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  size: 24,
                ),
                Text(
                  "${ConstString.cart} ${hiveController.number.value}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const Column(
              children: [
                Icon(Icons.group),
                Text(ConstString.seller , textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
              ],
            ),
            const Column(
              children: [
                Icon(
                  Icons.person,
                  size: 24,
                ),
                Text(ConstString.profile, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
              ],
            ),
          ]),

      body: Obx(() => pages[productListController.indexNumber.value]),
    );
  }
}
