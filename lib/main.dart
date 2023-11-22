import 'package:demo_alor_feri/pages/home_page.dart';
import 'package:demo_alor_feri/pages/login_page.dart';
import 'package:demo_alor_feri/pages/products_list_page.dart';
import 'package:demo_alor_feri/pages/users_list_pages.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
