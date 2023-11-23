import 'dart:convert';

import 'package:demo_alor_feri/pages/my_products.dart';
import 'package:demo_alor_feri/pages/products_list_page.dart';
import 'package:demo_alor_feri/pages/users_list_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../value/self_string.dart';
import 'package:http/http.dart' as http;

class LogInController extends GetxController {
  var access_token = "".obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<bool> logIn() async {
    try {
      isLoading.value = true;
      print(emailController.text);
      print(passwordController.text);

      final url = Uri.parse("${SelfString.serverUrl}${SelfString.login}");

      var header = {"Content-Type": "application/json"};

      var body = {
        "grant_type": "password",
        "client_id": 2,
        "client_secret": "Cr1S2ba8TocMkgzyzx93X66szW6TAPc1qUCDgcQo",
        "username": emailController.text.trim(),
        "password": passwordController.text.trim()
      };


      var response =
          await http.post(url, body: jsonEncode(body), headers: header);
      isLoading.value = false;

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        access_token.value = data['access_token'];
        print(access_token.value) ;
        return true ;

        Get.to(() => ProductsListPage());
      } else {
        print('error');
      }
    } catch (e) {}
    return false ;
  }
}
