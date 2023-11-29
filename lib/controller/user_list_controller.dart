import 'dart:convert';

import 'package:demo_alor_feri/value/const_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/seller.dart';

class SellerListController extends GetxController {
  RxList sellerList = [].obs;
  RxBool isLoading = false.obs;




  Future<void> fetchUsersLList() async {
    try {
      isLoading.value = true;
      final url = Uri.parse("${ConstString.serverUrl}${ConstString.userApi}");

      var response = await http.get(url);
      isLoading.value = false;

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        var data = jsonData['data'];



        for(var item in data) {
          sellerList.add(Seller.fromJson(item)) ;
        }




      } else {}
    } catch (e) {}
  }












}
