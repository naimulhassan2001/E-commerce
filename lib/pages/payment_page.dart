import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/payment_controller.dart';
import '../value/const_image.dart';
import '../value/const_string.dart';
import '../widget/custom_button.dart';

class Payment extends StatelessWidget {
  Payment({
    super.key,
    required this.price,
    required this.onTap,
  });

  num price;
  Function() onTap;

  PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstString.payment),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    ConstString.makePayment,
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${ConstString.payableAmount}: $price \৳",
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Obx(() => Checkbox(
                    value: paymentController.bkash.value,
                    onChanged: (value) {
                      paymentController.valueBkash(value);
                    })),
                Image.asset(
                  ConstImage.bkash,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(ConstString.bkash),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Obx(() => Checkbox(
                    value: paymentController.nagad.value,
                    onChanged: (value) {
                      paymentController.valueNagad(value);
                    })),
                Image.asset(
                  ConstImage.nagad,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(ConstString.nagad)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Obx(() => Checkbox(
                    value: paymentController.stripe.value,
                    onChanged: (value) {
                      paymentController.valueStripe(value);
                    })),
                Image.asset(
                  ConstImage.stripe,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(ConstString.stripe)
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 150,
              child: CustomButton(
                title: ConstString.submit,
                onTap: onTap,
              ),
            )
          ],
        ),
      ),
    );
  }
}
