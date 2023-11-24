import 'dart:convert';

import 'package:get/get.dart';

import '../value/string.dart';
import 'package:http/http.dart' as http;

class ProductListController extends GetxController {
  final RxList productsList = [].obs;

  final RxBool isLoading = false.obs;

  Future<void> fetchProductList() async {
    try {
      isLoading.value = true;
      final url = Uri.parse("${SelfString.serverUrl}${SelfString.product}");

      var response = await http.get(url);
      isLoading.value = false;

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        productsList.value = data['data'];
      } else {}
    } catch (e) {}
  }
}
