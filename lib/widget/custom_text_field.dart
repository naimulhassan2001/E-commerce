import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.radius = 0.0,
      required this.title,
      required this.controller,
      this.horizontal = 0});

  double radius;

  double horizontal;

  String title;

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: title,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius))),
      ),
    );
  }
}
