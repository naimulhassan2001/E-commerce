import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.color = Colors.red,
      required this.title,
      this.horizontal = 20,
      required this.onTap});

  Color color;
  String title;

  double horizontal;

  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          color: color,
          child: Center(
              child: Text(title,
                  style: const TextStyle(color: Colors.white, fontSize: 18))),
        ),
      ),
    );
  }
}
