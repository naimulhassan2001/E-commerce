import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/boxes.dart';
import '../model/product.dart';
import '../value/const_string.dart';
import 'package:http/http.dart' as http;

class ProductListController extends GetxController {

  TextEditingController searchController = TextEditingController() ;


  final RxList productsList = [].obs;
  RxInt indexNumber = 0.obs ;


  final RxBool isLoading = false.obs;

  final RxDouble gridHeight = 0.0.obs;

  @override
  void onInit() {
    fetchProductList();
    super.onInit();
  }





  Future<void> fetchProductList() async {
    try {
      isLoading.value = true;
      final url = Uri.parse("${ConstString.serverUrl}${ConstString.productApi}");

      var response = await http.get(url);
      isLoading.value = false;

      if (response.statusCode == 200) {

        var jsonData = jsonDecode(response.body);

        var data= jsonData['data'];

        for(var item in data) {
          productsList.add(Product.fromJson(item)) ;
        }




        gridHeight.value = ( (productsList.length)/3 ) * 252 ;


      } else {

      }
    } catch (e) {
      
    }
  }
}
