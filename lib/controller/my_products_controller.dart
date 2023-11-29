import 'dart:convert';

import 'package:demo_alor_feri/controller/login_controller.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../value/const_string.dart';
import 'package:http/http.dart' as http;

class MyProductsController extends GetxController {
  final RxList myProductsList = [].obs;

  final RxBool isLoading = false.obs;

  LogInController logInController = LogInController();

  Future<void> fetchMyProductList(String token) async {

    try {

      isLoading.value = true;
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer $token"
      };
      final url = Uri.parse("${ConstString.serverUrl}${ConstString.myProductsApi}");

      var response = await http.get(url, headers: headers);
      isLoading.value = false;

      if (response.statusCode == 200) {

        var jsonData = jsonDecode(response.body);

        var data= jsonData['data'];

        for(var item in data) {
          myProductsList.add(Product.fromJson(item)) ;
        }
      } else {

      }
    } catch (e) {}
  }
}
