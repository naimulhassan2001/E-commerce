import 'package:flutter/material.dart';

import '../value/const_image.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            ConstImage.appLogo,
            height: 60,
            width: 60,
          ),
        ));
  }
}
