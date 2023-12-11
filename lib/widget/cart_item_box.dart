import 'package:flutter/material.dart';

import '../model/boxes.dart';
import '../model/note_model.dart';

class CartItemBox extends StatelessWidget {
  CartItemBox({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.buttonTitle,
  });

  String buttonTitle;

  TextEditingController titleController;

  TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Notes'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Canecl')),
        TextButton(
            onPressed: () {
              titleController.clear();
              descriptionController.clear();

              Navigator.pop(context);
            },
            child: Text(buttonTitle)),
      ],
    );
  }
}
