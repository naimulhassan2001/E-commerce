import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  ProductListItem(
      {super.key,
      required this.productName,
      required this.ownerName,
      required this.price,
      required this.id,
      required this.index});

  int id;

  int price;
  int index;

  String productName;

  String ownerName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CircleAvatar(
              child: Text((index + 1).toString()),
            ),
          ),
          Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product Id:$id"),
                  const SizedBox(
                    height: 4,
                  ),
                  Text("Product Name: $productName"),
                  const SizedBox(
                    height: 4,
                  ),
                  Text("Price: $price"),
                  const SizedBox(
                    height: 4,
                  ),
                  Text("Product Owner : $ownerName"),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
