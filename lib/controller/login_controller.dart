import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../pages/home.dart';
import '../value/const_string.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogInController extends GetxController {
  RxString accessToken = "".obs;
  RxBool isLogIn = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  onInit() {
    getIsisLogIn();
    super.onInit();
  }

  Future<String> getIsisLogIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    accessToken.value = pref.getString("accessToken") ?? "";
    isLogIn.value = pref.getBool("isLogIn") ?? false;
    return accessToken.value;
  }

  setIsisLogIn(String token, bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("accessToken", token);
    pref.setBool("isLogIn", value);
  }

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
        isLogIn(true);
        setIsisLogIn(data['access_token'], true);

        Get.offAll(Home());
      } else {}
    } catch (e) {}
  }
}
