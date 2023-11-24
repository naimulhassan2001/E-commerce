import 'package:demo_alor_feri/controller/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../value/string.dart';
import '../widget/app_logo_widget.dart';
import '../widget/custom_button.dart';
import '../widget/custom_background.dart';
import '../widget/custom_text_field.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return CustomBackground(
        child: Column(
      children: [
        SizedBox(height: height * 0.1),
        const AppLogoWidget(),
        const SizedBox(height: 20),
        const Text(
          SelfString.registrationHint,
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() => Center(
                            child: registrationController.isLoading.value
                                ? const CircularProgressIndicator()
                                : null,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        title: "Name",
                        controller: registrationController.nameController,
                        horizontal: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        title: "E-mail",
                        controller: registrationController.emailController,
                        horizontal: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        title: "Password",
                        controller: registrationController.passwordController,
                        horizontal: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Obx(() => Checkbox(
                              value: registrationController.check.value,
                              onChanged: (value) {
                                registrationController.check.value = value!;
                              })),
                          const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child:
                                Expanded(child: Text(SelfString.privacyPolicy)),
                          )
                        ],
                      ),
                      CustomButton(
                        title: "Sign Up",
                        onTap: () {
                          registrationController.registration();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ],
    ));
  }
}
