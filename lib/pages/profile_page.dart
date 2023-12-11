import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_market/controller/cart_controller.dart';
import 'package:super_market/controller/product_list_controller.dart';
import 'package:super_market/pages/cart_page.dart';
import 'package:super_market/pages/home.dart';
import 'package:super_market/pages/my_products_page.dart';
import 'package:super_market/widget/custom_background.dart';
import 'package:super_market/widget/custom_button.dart';
import 'package:super_market/widget/profile_grid_item.dart';
import 'package:super_market/widget/seller_girdview_item.dart';

import '../controller/login_controller.dart';
import '../controller/profile_controller.dart';
import '../value/const_image.dart';
import '../value/const_string.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key, this.profileAppBar = false});

  ProfileController profileController = Get.put(ProfileController());

  LogInController logInController = Get.put(LogInController());

  CartController cartController = Get.put(CartController());

  ProductListController productListController =
      Get.put(ProductListController());

  bool profileAppBar;

  @override
  Widget build(BuildContext context) {
    var token = logInController.getIsisLogIn();
    token.then((value) {
      profileController.fetchProfileInfo(value);
    });

    return Scaffold(
        appBar: profileAppBar
            ? AppBar(
                title: const Text(ConstString.myProfile),
              )
            : null,
        body: Obx(() => Center(
            child: profileController.isLoading.value
                ? const CircularProgressIndicator()
                : Center(
                    child: profileController.profileInfo.isNotEmpty
                        ? CustomBackground(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: CircleAvatar(
                                        radius: 40,
                                        child: ClipOval(
                                            child: profileController
                                                    .profileInfo[0]
                                                    .url
                                                    .isNotEmpty
                                                ? Image.network(
                                                    "${ConstString.serverUrl}${profileController.profileInfo[0].url}")
                                                : Image.asset(
                                                    ConstImage.profile)),
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SingleChildScrollView(
                                            child: Text(
                                              profileController
                                                  .profileInfo[0].name, maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                              profileController
                                                  .profileInfo[0].email,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                              profileController
                                                  .profileInfo[0].mobile,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    )),
                                    TextButton(
                                        onPressed: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                color: Colors.white,
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: GestureDetector(
                                              onTap: () {
                                                logInController.setIsisLogIn(
                                                    "", false);
                                                productListController
                                                    .indexNumber.value = 0;
                                                profileController
                                                    .profileInfo.value = [];
                                                logInController.isLogIn.value =
                                                    false;
                                                logInController
                                                    .accessToken.value = "";
                                              },
                                              child:
                                                  const Text(ConstString.logOut,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      )),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: ()=>Get.to(CartPage()),
                                      child: ProfileGridItem(
                                        title: ConstString.myCartList,
                                        count: cartController.number.value
                                            .toString(),
                                      ),
                                    ),
                                    ProfileGridItem(
                                        title: ConstString.myOrders, count: "00"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 4,
                                              offset: Offset(
                                                  0, 4), // Shadow position
                                            ),
                                          ],
                                        ),
                                        child: MyProductsListPage(
                                            myProductAppBar: false),
                                      )),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              Get.to(LogInPage());
                            },
                            child: const Text(ConstString.logIn))))));
  }
}
