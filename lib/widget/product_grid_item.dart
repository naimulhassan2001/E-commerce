import 'package:demo_alor_feri/value/const_image.dart';
import 'package:flutter/material.dart';
import 'package:demo_alor_feri/value/const_string.dart';

class ProductGridItem extends StatelessWidget {
  ProductGridItem(
      {super.key,
      required this.productName,
      required this.price,
      required this.id,
      required this.index,
      required this.url,
      required this.stock});

  int price;
  int index;
  int stock;

  String id;
  String productName;
  String url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        child: Column(
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
                      : Image.asset(ConstImage.blank)),
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(productName)),
                      const SizedBox(
                        height: 4,
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text("\৳ ${price.toString()}")),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("${ConstString.available}: ${stock.toString()}", maxLines: 1,)),

                      SizedBox(height: 10,)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
