import 'dart:convert';

import 'package:demo_alor_feri/value/self_string.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersListController extends GetxController {
  RxList usersList = [].obs;
  RxBool isLoading = false.obs;

  Future<void> fetchUsersLList() async {
    try {
      isLoading.value = true;
      final url = Uri.parse("${SelfString.serverUrl}${SelfString.user}");

      var response = await http.get(url);
      isLoading.value = false;

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        usersList.value = data['data'];
      } else {}
    } catch (e) {}
  }
}
