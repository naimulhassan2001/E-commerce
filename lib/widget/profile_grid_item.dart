import 'package:flutter/material.dart';

class ProfileGridItem extends StatelessWidget {
  ProfileGridItem({
    super.key,
    required this.title,
    required this.count,
  });

  String count;

  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.30,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(count),
              const SizedBox(
                height: 4,
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
