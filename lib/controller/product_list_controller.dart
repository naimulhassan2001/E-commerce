import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../value/const_string.dart';
import 'package:http/http.dart' as http;

class ProductListController extends GetxController {
  TextEditingController searchController = TextEditingController();

  final RxList productsList = [].obs;
  RxInt indexNumber = 0.obs;

  ScrollController scrollController = ScrollController();

  final RxBool isLoading = false.obs;
  final RxDouble gridHeight = 0.0.obs;
  RxDouble value = 0.0.obs;

  int page = 1;

  @override
  void onInit() {
    fetchProductList();
    scrollController.addListener(() {
      _scrollControllerCall();
    });
    super.onInit();
  }

  Future<void> _scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await fetchProductList();
    }
  }

  Future<void> fetchProductList() async {
    try {
      isLoading.value = true;
      final url = Uri.parse(
          "${ConstString.serverUrl}${ConstString.productApi}?page=$page");

      var response = await http.get(url);
      isLoading.value = false;

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        page = page + 1;

        var data = jsonData['data'];

        for (var item in data) {
          productsList.add(Product.fromJson(item));
        }

        gridHeight.value = ((productsList.length) / 2) * 322;
      } else {}
    } catch (e) {}
  }
}
