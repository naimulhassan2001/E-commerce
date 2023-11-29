


import 'dart:convert';

import 'package:demo_alor_feri/model/product.dart';
import 'package:get/get.dart';

import '../value/const_string.dart';

import 'package:http/http.dart' as http;


class SellerProductController extends GetxController {


  RxList sellerProductList = [].obs;

  RxBool isLoading = false.obs;



  Future<void> fetchSellerProduct( String id) async {
    try {

      isLoading.value = true;
      final url = Uri.parse("${ConstString.serverUrl}${ConstString.userApi}/$id/products");

      var response = await http.get(url);
      isLoading.value = false;

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        var data = jsonData['data'];

        for(var item in data) {
          sellerProductList.add(Product.fromJson(item)) ;
        }





      } else {

      }
    } catch (e) {}
  }



}