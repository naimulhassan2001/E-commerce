import 'dart:convert';

import 'package:demo_alor_feri/pages/users_list_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../value/self_string.dart';
import 'package:http/http.dart' as http;

class LogInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<void> logIn() async {
    try {
      isLoading.value = true;

      print('object') ;
      final url = Uri.parse("${SelfString.serverUrl}${SelfString.product}");

      var response = await http.put(url,
          body: {
        "grant_type": "password",
        "client_id": 2,
        "client_secret": "Cr1S2ba8TocMkgzyzx93X66szW6TAPc1qUCDgcQo",
        "username": "nayem20012@gmail.com",
        "password": "nayem20012@gmail.com"
      });
      isLoading.value = false;

      if (response.statusCode == 200) {
        print('hello') ;

        var data = jsonDecode(response.body);
        Get.to(UsersListPage);
      } else {
        print('error') ;

      }
    } catch (e) {}
  }
}
