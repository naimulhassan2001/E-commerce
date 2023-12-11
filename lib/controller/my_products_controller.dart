import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_market/controller/login_controller.dart';

import '../model/product.dart';
import '../value/const_string.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as _dio;

class MyProductsController extends GetxController {
  final RxList myProductsList = [].obs;
  final RxBool isLoading = false.obs;
  final RxBool isImage = false.obs;

  TextEditingController nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController stockController = TextEditingController();

  LogInController logInController = LogInController();

  getImage(value) {
    isImage.value = value;
  }

  Future<void> fetchMyProductList(String token) async {
    try {
      isLoading.value = true;
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer $token"
      };
      final url =
          Uri.parse("${ConstString.serverUrl}${ConstString.myProductsApi}");

      var response = await http.get(url, headers: headers);
      isLoading.value = false;

      if (response.statusCode == 200) {
        myProductsList.value = [];

        var jsonData = jsonDecode(response.body);

        var data = jsonData['data'];

        for (var item in data) {
          myProductsList.add(Product.fromJson(item));
        }
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateMyProduct(XFile? image, String token, String id) async {
    try {
      _dio.Dio dio = _dio.Dio();

      _dio.FormData fromData = _dio.FormData.fromMap({
        'image': await _dio.MultipartFile.fromFile(image!.path),
        'name': nameController.text,
        'price': priceController.text,
        'stock_quantity': stockController.text,
      });

      dio.options.headers['Authorization'] = "Bearer $token";

      var url =
          "${ConstString.serverUrl}${ConstString.myProductsApi}/$id/${ConstString.updateApi}";

      _dio.Response response = await dio.post(
        url,
        data: fromData,
      );
      if (response.statusCode == 200) {
        fetchMyProductList(token);
        nameController.clear();
        priceController.clear();
        stockController.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addMyProduct(XFile? image, String token) async {
    try {
      _dio.Dio dio = _dio.Dio();

      _dio.FormData fromData = _dio.FormData.fromMap({
        'image': await _dio.MultipartFile.fromFile(image!.path),
        'name': nameController.text,
        'price': priceController.text,
        'stock_quantity': stockController.text,
      });

      dio.options.headers['Authorization'] = "Bearer $token";

      var url = "${ConstString.serverUrl}${ConstString.myProductsApi}";

      _dio.Response response = await dio.post(
        url,
        data: fromData,
      );
      if (response.statusCode == 200) {
        fetchMyProductList(token);
        nameController.clear();
        priceController.clear();
        stockController.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteMyProduct(String token, String id) async {
    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer $token"
      };

      final url =
          Uri.parse("${ConstString.serverUrl}${ConstString.myProductsApi}/$id");

      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        fetchMyProductList(token);
      } else {}
    } catch (e) {
      print(e) ;
    }
  }
}
