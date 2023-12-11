import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../value/const_string.dart';

class RegistrationController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conformPasswordController =
      TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool check = false.obs;

  Future<void> registration() async {
    try {
      isLoading.value = true;
      Map<String, String> headers = {
        'Content-type': 'application/json',
      };

      var body = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "password_confirmation": conformPasswordController.text
      };

      final url =
          Uri.parse("${ConstString.serverUrl}${ConstString.registrationApi}");

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      isLoading.value = false;

      if (response.statusCode == 200) {
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        conformPasswordController.clear();
        Get.back();
      } else {}
    } catch (e) {}
  }
}
