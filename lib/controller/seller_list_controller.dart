import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/seller.dart';
import '../value/const_string.dart';

class SellerListController extends GetxController {
  RxList sellerList = [].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;

  ScrollController scrollController = ScrollController();

  int page = 1;

  @override
  onInit() {
    fetchUsersLList();
    scrollController.addListener(() {
      _scrollControllerCall();
    });
    super.onInit();
  }

  Future<void> _scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await fetchUsersLList();
    }
  }

  Future<void> fetchUsersLList() async {
    try {
      isLoadingMore.value = true;

      final url = Uri.parse(
          "${ConstString.serverUrl}${ConstString.userApi}?page=$page");

      var response = await http.get(url);
      isLoadingMore.value = false;

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        page = page + 1;

        var data = jsonData['data'];

        for (var item in data) {
          sellerList.add(Seller.fromJson(item));
        }
      } else {}
    } catch (e) {}
  }
}
