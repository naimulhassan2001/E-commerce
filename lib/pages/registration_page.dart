import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/registration_controller.dart';
import '../value/const_image.dart';
import '../value/const_string.dart';
import '../widget/app_logo_widget.dart';
import '../widget/custom_button.dart';
import '../widget/custom_background.dart';
import '../widget/custom_text_field.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  RegistrationController registrationController =
      Get.put(RegistrationController());

  final GlobalKey<FormState> _formKey = GlobalKey();


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
          ConstString.registrationHint,
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
                  child: Form(
                    key: _formKey,
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
                          validator: true,
                          title: ConstString.name,
                          controller: registrationController.nameController,
                          horizontal: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          validator: true,
                          title: ConstString.email,
                          controller: registrationController.emailController,
                          horizontal: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          validator: true,
                          title: ConstString.password,
                          controller: registrationController.passwordController,
                          horizontal: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          validator: true,
                          title: ConstString.conformPassword,
                          controller:
                              registrationController.conformPasswordController,
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
                              child: Text(ConstString.privacyPolicy),
                            )
                          ],
                        ),
                        CustomButton(
                          title: ConstString.signUp,
                          onTap: () {
                            if(_formKey.currentState!.validate()) {
                              registrationController.registration();

                            }
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ConstString.signUpWith,
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey[300],
                                  child: Image.asset(ConstImage.google,
                                      width: 30, height: 30)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey[300],
                                  child: Image.asset(ConstImage.facebook,
                                      width: 30, height: 30)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey[300],
                                  child: Image.asset(ConstImage.twitter,
                                      width: 30, height: 30)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                ConstString.alreadyHavAccount,
                                style: TextStyle(color: Colors.black),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    ConstString.logIn,
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
                  ),
                )),
          ),
        ),
      ],
    ));
  }
}
