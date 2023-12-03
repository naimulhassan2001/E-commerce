import 'dart:convert';

import 'package:demo_alor_feri/controller/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../value/const_string.dart';
import 'package:http/http.dart' as http;

class MyProductsController extends GetxController {
  final RxList myProductsList = [].obs;
  final RxBool isLoading = false.obs;



  TextEditingController namecontroller = TextEditingController() ;
  TextEditingController pricecontroller = TextEditingController() ;
  TextEditingController stockcontroller = TextEditingController() ;





  LogInController logInController = LogInController();


  Future<void> fetchMyProductList(String token) async {

    try {

      myProductsList.value = [] ;
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


  Future<void> addMyProduct(String token) async {

    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer $token"
      };

      var body =   {
          "name" : namecontroller.text,
          "price" : pricecontroller.text,
          "stock_quantity" : stockcontroller.text
        }
       ;


      final url = Uri.parse("${ConstString.serverUrl}${ConstString.myProductsApi}");

      var response = await http.post(url, headers: headers,body: jsonEncode(body) );

      if (response.statusCode == 200) {

        fetchMyProductList(token);
        namecontroller.clear();
        pricecontroller.clear();
        stockcontroller.clear();
      } else {

      }
    } catch (e) {}
  }


  Future<void> updateMyProduct(String token, String id) async {

    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer $token"
      };

      var body =   {
          "name" : namecontroller.text,
          "price" : pricecontroller.text,
          "stock_quantity" : stockcontroller.text
        }
       ;


      final url = Uri.parse("${ConstString.serverUrl}${ConstString.myProductsApi}/$id/${ConstString.updateApi}");

      var response = await http.post(url, headers: headers,body: jsonEncode(body) );

      if (response.statusCode == 200) {

        print("object");
        fetchMyProductList(token);
        namecontroller.clear();
        pricecontroller.clear();
        stockcontroller.clear();
      } else {

        print("hello");

      }
    } catch (e) {}
  }


  Future<void> deleteMyProduct(String token, String id) async {

    try {
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': "Bearer $token"
      };


      final url = Uri.parse("${ConstString.serverUrl}${ConstString.myProductsApi}/$id");

      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {

        fetchMyProductList(token);
      } else {

      }
    } catch (e) {}
  }






  Future<void> createProduct(BuildContext context) async{


    return showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title:  const Text(ConstString.addProduct),
          content:  SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      labelText: ConstString.productName,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: pricecontroller,
                  decoration: InputDecoration(
                      labelText: ConstString.price,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: stockcontroller,
                  decoration: InputDecoration(
                      labelText: ConstString.stock,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context) ;
              print("object");
            },
                child: const Text(ConstString.canecl)),
            TextButton(onPressed: () {
              addMyProduct(logInController.accessToken.value ) ;
              Navigator.pop(context) ;
            },
                child: const Text(ConstString.add)),
          ],
        );
      },) ;




  }


}
