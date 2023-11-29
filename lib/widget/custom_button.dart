import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.color = Colors.red,
      required this.title,
      this.horizontal = 20,
      this.height = 50,
        this.fontSize = 18,
        this.radius =0,
      required this.onTap});

  Color color;
  String title;
  double horizontal;
  Function() onTap;
  double height;
  double fontSize;
  double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radius)),
          child: Center(
              child: Text(title,
                  style: TextStyle(color: Colors.white, fontSize: fontSize))),
        ),
      ),
    );
  }
}
