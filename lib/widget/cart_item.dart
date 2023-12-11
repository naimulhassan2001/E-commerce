import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../model/note_model.dart';
import '../value/const_image.dart';
import '../value/const_string.dart';

class CartItem extends StatelessWidget {
  CartItem({
    super.key,
    required this.notesModel,
  });

  NotesModel notesModel;

  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                  child: notesModel.url.isNotEmpty
                      ? Image.network(
                    "${ConstString.serverUrl}${notesModel.url}",
                    fit: BoxFit.cover,
                  )
                      : Image.asset(ConstImage.blank)),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text("Name: ${notesModel.name}"),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Price: ${notesModel.price * notesModel.stock_quantity} \৳",
                        style: const TextStyle(),
                        maxLines: 1,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: decrement,
                              child: Image.asset(
                                ConstImage.subtract,
                                width: 20,
                                height: 20,
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(notesModel.stock_quantity.toString()),
                          ),
                          GestureDetector(
                              onTap: increment,
                              child: const Icon(Icons.add_circle)),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                cartController.isCartAdded.remove(notesModel.id);
                                notesModel.delete();

                              },
                              icon: const Icon(Icons.delete_rounded))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  increment() {
    notesModel.stock_quantity = notesModel.stock_quantity + 1;
    notesModel.save();
  }

  decrement() {
    if (notesModel.stock_quantity != 1) {
      notesModel.stock_quantity = notesModel.stock_quantity - 1;
      notesModel.save();
    }
  }
}
