import 'dart:convert';
import 'package:demo_alor_feri/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../value/const_string.dart';
import 'package:http/http.dart' as http;

class LogInController extends GetxController {

  var accessToken = "".obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<void> logIn() async {
    try {
      isLoading.value = true;

      final url = Uri.parse("${ConstString.serverUrl}${ConstString.loginApi}");

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
        accessToken.value = data['access_token'];
        Get.offAll(Home());
      } else {}
    } catch (e) {}
  }
}
