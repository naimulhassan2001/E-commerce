

import 'package:demo_alor_feri/value/const_image.dart';
import 'package:flutter/material.dart';

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
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Container(
                child: url.isNotEmpty
                    ? Image.network(
                  "${ConstString.serverUrl}$url",
                  fit: BoxFit.cover,
                )
                    : Image.asset(ConstImage.profile)),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(name, maxLines: 2),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
