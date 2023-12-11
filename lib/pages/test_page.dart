import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_market/controller/login_controller.dart';
import 'package:super_market/controller/profile_controller.dart';
import 'package:super_market/pages/login_page.dart';
import 'package:super_market/pages/my_products_page.dart';

import '../value/const_image.dart';
import '../value/const_string.dart';
import 'profile_page.dart';
import 'seller_list_pages.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

ProfileController profileController = Get.put(ProfileController());

LogInController logInController = Get.put(LogInController());

double value = 0;

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blue[400]!,
              Colors.blue[800]!,
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          SafeArea(
              child: Container(
            padding: EdgeInsets.all(8.0),
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    accountName: Text("Naimul Hassan"),
                    accountEmail: Text("naimul@gmail.com"),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ConstImage.profileBackground),
                            fit: BoxFit.fill)),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(child: Image.asset(ConstImage.profile)),
                    )),
                ListTile(
                  title: const Text(ConstString.myProducts,
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.white,
                  ),
                  onTap: () {
                    if (logInController.accessToken.value.isNotEmpty) {
                      Get.to(MyProductsListPage());
                    } else {
                      Get.to(LogInPage());
                    }
                  },
                ),
                ListTile(
                  title: const Text(ConstString.seller,
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.groups,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Get.to(SellerListPage());
                  },
                ),
                ListTile(
                  title: const Text(ConstString.profile,
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.person_pin,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Get.to(ProfilePage(
                      profileAppBar: true,
                    ));
                  },
                ),
                ListTile(
                  title: const Text(ConstString.share,
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: const Text(ConstString.setting,
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.settings, color: Colors.white),
                  onTap: () {
                    logInController.accessToken.value = "";
                  },
                ),
                ListTile(
                  title: const Text(ConstString.logOut,
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onTap: () {
                    logInController.accessToken.value = "";
                  },
                )
              ],
            ),
          )),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 500),
              builder: (context, val, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..setEntry(0, 3, 200 * val)
                    ..rotateY((pi / 6) * val),
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('3D Animation'),
                    ),
                    body: Center(
                      child: Text("3D Animation"),
                    ),
                  ),
                );
              }),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              } else {
                setState(() {
                  value = 0;
                });
              }
            },
          )
        ],
      ),
    );
  }
}
