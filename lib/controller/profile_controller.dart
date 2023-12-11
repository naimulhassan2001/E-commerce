import 'dart:convert';

import 'package:get/get.dart';

import '../model/profile.dart';
import '../value/const_string.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;

  RxList profileInfo = [].obs;

  Future<void> fetchProfileInfo(String token) async {
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer $token"
      };
      final url =
          Uri.parse("${ConstString.serverUrl}${ConstString.userApi}/me");

      var response = await http.get(url, headers: headers);
      isLoading.value = false;

      if (response.statusCode == 200) {
        profileInfo.value = [];

        var jsonData = jsonDecode(response.body);

        var data = jsonData['data'];
        profileInfo.add(Profile.fromJson(data));
      } else {}
    } catch (e) {}
  }
}
