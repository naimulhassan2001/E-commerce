import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.radius = 0.0,
      required this.title,
      required this.controller,
      this.height = 56,
      this.suffix,
      this.validator = false,
      this.horizontal = 0});

  double radius;
  double horizontal;
  String title;
  double height;
  Icon? suffix;
  bool validator;

  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator
            ? (value) {
          if (value!.isEmpty) {
            return 'please enter $title';
          }
          return null;
        }
            : null,
        decoration: InputDecoration(
            labelText: title,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius))),
      ),
    );
  }
}
