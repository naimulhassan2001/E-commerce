import 'package:demo_alor_feri/controller/user_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersListPage extends StatelessWidget {
  UsersListPage({super.key});

  final UsersListController usersListController =
      Get.put(UsersListController());

  @override
  Widget build(BuildContext context) {
    usersListController.fetchUsersLList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Obx(() =>usersListController.isLoading.value ?  const Center( child: CircularProgressIndicator(),)
          : ListView.builder(
        itemCount: usersListController.usersList.length,
        itemBuilder: (context, index) {
          var user = usersListController.usersList[index];
          return ListTile(
            title: Text(user['name']),
            subtitle: Text(user['email']),
          );
        },
      )),
    );
  }
}
