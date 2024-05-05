import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:user_list_sample/src/getx/user_list.dart';
import 'package:user_list_sample/src/getx/user_list_controller.dart';
import 'package:user_list_sample/src/set_state/user_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserListPageSetState(),
                    ),
                  );
                },
                child: const Text('SetState 상태관리')),
            ElevatedButton(
                onPressed: () {
                  Get.put(UserListController());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserListForGetX(),
                    ),
                  );
                },
                child: const Text('GetX 상태관리')),
            ElevatedButton(onPressed: () {}, child: const Text('Extends 상태관리')),
            ElevatedButton(
                onPressed: () {}, child: const Text('CopyWith 상태관리')),
          ],
        ),
      ),
    );
  }
}
