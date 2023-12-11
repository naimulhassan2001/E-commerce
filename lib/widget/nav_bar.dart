import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_market/controller/product_list_controller.dart';

import '../controller/login_controller.dart';
import '../controller/profile_controller.dart';
import '../pages/login_page.dart';
import '../pages/my_products_page.dart';
import '../pages/profile_page.dart';
import '../pages/seller_list_pages.dart';
import '../value/const_image.dart';
import '../value/const_string.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  LogInController logInController = Get.put(LogInController());
  ProfileController profileController = Get.put(ProfileController());
  ProductListController productListController =
      Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    var aa = logInController.getIsisLogIn();
    aa.then((value) {
      profileController.fetchProfileInfo(value);
    });

    return Obx(() => SafeArea(
        child: logInController.isLogIn.value
            ? Center(
                child: Obx(() => profileController.profileInfo.isNotEmpty
                    ? ListView(
                        children: [
                          UserAccountsDrawerHeader(
                              accountName:
                                  Text(profileController.profileInfo[0].name),
                              accountEmail:
                                  Text(profileController.profileInfo[0].email),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          ConstImage.profileBackground),
                                      fit: BoxFit.fill)),
                              currentAccountPicture: CircleAvatar(
                                child: ClipOval(
                                    child: profileController
                                            .profileInfo[0].url.isNotEmpty
                                        ? Image.network(
                                            "${ConstString.serverUrl}${profileController.profileInfo[0].url}")
                                        : Image.asset(ConstImage.profile)),
                              )),
                          ListTile(
                            title: const Text(
                              ConstString.myProducts,
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: const Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.white,
                            ),
                            onTap: () {
                              if (logInController
                                  .accessToken.value.isNotEmpty) {
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
                          const ListTile(
                            title: Text(ConstString.setting,
                                style: TextStyle(color: Colors.white)),
                            leading: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                          ListTile(
                            title: const Text(ConstString.logOut,
                                style: TextStyle(color: Colors.white)),
                            leading: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            onTap: () {
                              logInController.setIsisLogIn("", false);
                              productListController.indexNumber.value = 0;
                              logInController.isLogIn.value = false;
                              logInController.accessToken.value = "";
                            },
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator())),
              )
            : Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Center(
                    child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          Get.to(LogInPage());
                        },
                        child: const Text(
                          ConstString.logIn,
                          style: TextStyle(color: Colors.black),
                        ))),
              )));
  }
}
