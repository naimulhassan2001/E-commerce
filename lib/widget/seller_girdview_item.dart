import 'package:flutter/material.dart';

import '../value/const_image.dart';
import '../value/const_string.dart';

class SellerGirdViewItem extends StatelessWidget {
  SellerGirdViewItem({
    super.key,
    required this.id,
    required this.name,
    required this.url,
  });

  String name;
  String url;
  String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Center(
              child: Container(
                  child: url.isNotEmpty
                      ? Image.network(
                          "${ConstString.serverUrl}$url",
                          fit: BoxFit.cover,
                        )
                      : Image.asset(ConstImage.profile)),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(name, maxLines: 1)),
                    const SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
