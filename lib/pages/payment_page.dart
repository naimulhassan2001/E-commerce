

import 'package:demo_alor_feri/model/note_model.dart';
import 'package:demo_alor_feri/value/const_image.dart';
import 'package:demo_alor_feri/value/const_string.dart';
import 'package:demo_alor_feri/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Payment extends StatelessWidget {
  Payment({
    super.key,
    required this.price,
  });

  num price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstString.payment),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Align(alignment: Alignment.center,
                  child: Text(ConstString.makePayment, style: TextStyle(fontSize: 18),)),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(alignment: Alignment.topLeft,
                  child: Text("${ConstString.payableAmount}: $price \৳", style: TextStyle(fontSize: 18),)),
            ),
            const SizedBox(height: 20,),


            Row(
              children: [

                Image.asset(ConstImage.bkash, width: 50, height: 50,),
                const SizedBox(width: 10,),
                const Text(ConstString.bkash),
              ],
            ),
            const SizedBox(height: 10,),

            Row(
              children: [
                Image.asset(ConstImage.nagad, width: 50, height: 50,),
                const SizedBox(width: 10,),
                const Text(ConstString.nagad)
              ],
            ),
            const SizedBox(height: 10,),

            Row(
              children: [
                Image.asset(ConstImage.stripe, width: 50, height: 50,),
                const SizedBox(width: 10,),
                const Text(ConstString.stripe)
              ],
            ),

            const SizedBox(height: 50,),

            SizedBox(
              width: 150,
              child: CustomButton(
                  title: ConstString.submit,
                  onTap: (){
                    // notesModel.delete();
                    Get.back() ;
                  },




              ),
            )




          ],
        ),
      ),
    );
  }
}
