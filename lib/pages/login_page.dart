import 'package:demo_alor_feri/controller/login_controller.dart';
import 'package:demo_alor_feri/pages/home.dart';
import 'package:demo_alor_feri/pages/registration_page.dart';
import 'package:demo_alor_feri/value/const_image.dart';
import 'package:demo_alor_feri/value/const_string.dart';
import 'package:demo_alor_feri/widget/app_logo_widget.dart';
import 'package:demo_alor_feri/widget/custom_button.dart';
import 'package:demo_alor_feri/widget/custom_background.dart';
import 'package:demo_alor_feri/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final LogInController logInController = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return CustomBackground(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
      children: [
            SizedBox(height: height * 0.05),
            const AppLogoWidget(),
            const SizedBox(height: 20),
            const Text(
              ConstString.logInHint,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none),
            ),
            Padding(
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
                            child: logInController.isLoading.value
                                ? const CircularProgressIndicator()
                                : null,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        title: ConstString.email,
                        controller: logInController.emailController,
                        horizontal: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        title: ConstString.password,
                        controller: logInController.passwordController,
                        horizontal: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              ConstString.forgetPassword,
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        title: ConstString.logIn,
                        onTap: () {
                            logInController.logIn();
                          // Get.to(Home()) ;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ConstString.createNewAccount,
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          title: ConstString.signUp,
                          color: Colors.teal,
                          onTap: () {
                            Get.to(RegistrationPage());
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ConstString.logWith,
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[300],
                                child: Image.asset(
                                    ConstImage.google,
                                    width: 30,
                                    height: 30)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[300],
                                child: Image.asset(
                                    ConstImage.facebook,
                                    width: 30,
                                    height: 30)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[300],
                                child: Image.asset(
                                    ConstImage.twitter,
                                    width: 30,
                                    height: 30)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )),
      ],
    ),
          ),
        ));
  }
}
