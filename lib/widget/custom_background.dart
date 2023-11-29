import 'package:demo_alor_feri/value/const_image.dart';
import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  CustomBackground({super.key, required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ConstImage.background),
                fit: BoxFit.fill)),
        child: child,
      ),
    );
  }
}
