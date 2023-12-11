import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_market/pages/product_detail_page.dart';
import 'package:super_market/widget/custom_text_field.dart';
import '../controller/login_controller.dart';
import '../controller/my_products_controller.dart';
import '../value/const_image.dart';
import '../value/const_string.dart';

class MyProductsListPage extends StatelessWidget {
  MyProductsListPage({super.key, this.myProductAppBar = true});

  bool myProductAppBar;

  LogInController logInController = Get.put(LogInController());
  MyProductsController myProductsController = Get.put(MyProductsController());

  XFile? image;
  final _picker = ImagePicker();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (logInController.accessToken.isNotEmpty) {
      if (myProductsController.myProductsList.isEmpty) {
        myProductsController
            .fetchMyProductList(logInController.accessToken.value);
      }
    } else {
      var token = logInController.getIsisLogIn();
      token.then((value) {
        if (myProductsController.myProductsList.isEmpty) {
          myProductsController.fetchMyProductList(value);
        }
      });
    }
    return Scaffold(
        appBar: myProductAppBar
            ? AppBar(
                title: const Text(ConstString.myProductList),
              )
            : null,
        floatingActionButton: myProductAppBar
            ? FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () {
                  image = null;
                  _showDialog(context);
                },
                child: const Icon(Icons.add, color: Colors.white),
              )
            : null,
        body: Obx(() => myProductsController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: myProductsController.myProductsList.length,
                itemBuilder: (context, index) {
                  var product = myProductsController.myProductsList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(ProductDetailPage(
                          id: product.id,
                          name: product.name,
                          price: product.price,
                          stockQuantity: product.stockQuantity,
                          url: product.url));
                    },
                    child: Card(
                      child: Container(
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Center(
                                  child: product.url.isNotEmpty
                                      ? Image.network(
                                          "${ConstString.serverUrl}${product.url}",
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(ConstImage.blank)),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Name: ${product.name}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Price: ${product.price} \৳",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        SingleChildScrollView(
                                            child: Text(
                                                "${ConstString.stock}: ${product.stockQuantity} ")),
                                        const Spacer(),
                                        GestureDetector(
                                            onTap: () {
                                              image = null;
                                              _update(
                                                  context,
                                                  product.id,
                                                  product.name,
                                                  product.price,
                                                  product.stockQuantity);
                                            },
                                            child: const Icon(
                                                Icons.edit_calendar_rounded)),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              _deleteMyProduct(
                                                  context, product.id);
                                            },
                                            child: const Icon(Icons.delete))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )));
  }

  _deleteMyProduct(BuildContext context, String id) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(ConstString.deleteProduct),
          content: const Text(ConstString.sureDelete),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(ConstString.cancel)),
            TextButton(
                onPressed: () {
                  myProductsController.deleteMyProduct(
                      logInController.accessToken.value, id);
                  Navigator.pop(context);
                },
                child: const Text(ConstString.delete)),
          ],
        );
      },
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    myProductsController.nameController.clear();
    myProductsController.priceController.clear();
    myProductsController.stockController.clear();

    myProductsController.getImage(false);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(ConstString.addProduct),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    radius: 10,
                    validator: true,
                    title: ConstString.productName,
                    controller: myProductsController.nameController,
                    horizontal: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    radius: 10,
                    validator: true,
                    title: ConstString.price,
                    controller: myProductsController.priceController,
                    horizontal: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    radius: 10,
                    validator: true,
                    title: ConstString.stock,
                    controller: myProductsController.stockController,
                    horizontal: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: GestureDetector(
                            onTap: getImage,
                            child: const Text(ConstString.pickImage)),
                      ),
                      Obx(() => Center(
                            child: myProductsController.isImage.value
                                ? Container(
                                    child: Image.file(
                                    File(image!.path).absolute,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.cover,
                                  ))
                                : null,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(ConstString.cancel)),
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    myProductsController.addMyProduct(
                        image, logInController.accessToken.value);
                    Navigator.pop(context);
                  }
                },
                child: const Text(ConstString.add)),
          ],
        );
      },
    );
  }

  Future<void> _update(BuildContext context, String id, String name, int price,
      int stock) async {
    myProductsController.nameController.text = name;
    myProductsController.priceController.text = price.toString();
    myProductsController.stockController.text = stock.toString();

    myProductsController.getImage(false);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(ConstString.updateProduct),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: myProductsController.nameController,
                  decoration: InputDecoration(
                      labelText: ConstString.productName,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: myProductsController.priceController,
                  decoration: InputDecoration(
                      labelText: ConstString.price,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: myProductsController.stockController,
                  decoration: InputDecoration(
                      labelText: ConstString.stock,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: GestureDetector(
                          onTap: getImage,
                          child: const Text(ConstString.pickImage)),
                    ),
                    Obx(() => Center(
                          child: myProductsController.isImage.value
                              ? Container(
                                  child: Image.file(
                                  File(image!.path).absolute,
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                ))
                              : null,
                        ))
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(ConstString.cancel)),
            TextButton(
                onPressed: () {
                  myProductsController.updateMyProduct(
                      image, logInController.accessToken.value, id);
                  Navigator.pop(context);
                },
                child: const Text(ConstString.update)),
          ],
        );
      },
    );
  }

  Future<void> getImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    myProductsController.getImage(true);
  }
}
