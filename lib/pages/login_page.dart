import 'package:demo_alor_feri/controller/login_controller.dart';
import 'package:demo_alor_feri/widget/self_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final LogInController logInController = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Center(
                  child: logInController.isLoading.value
                      ? const CircularProgressIndicator()
                      : null,
                ),
              ),
              SelfTextField(
                title: "E-mail",
                controller: logInController.emailController,
                horizontal: 20,
                radius: 8,
              ),
              const SizedBox(
                height: 10,
              ),
              SelfTextField(
                title: "password",
                controller: logInController.passwordController,
                horizontal: 20,
                radius: 8,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    logInController.logIn();
                  },
                  child: const Text("Log IN"))
            ],
          ),
        ),
      ),
    );
  }
}
