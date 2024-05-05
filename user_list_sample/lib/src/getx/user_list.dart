import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:user_list_sample/src/components/user_info.dart';
import 'package:user_list_sample/src/getx/user_list_controller.dart';
import 'package:user_list_sample/src/model/user_info_result.dart';

class UserListForGetX extends GetView<UserListController> {
  const UserListForGetX({super.key});

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _error() {
    return const Center(
      child: Text('오류발생'),
    );
  }

  Widget _userListWidget(List<UserInfo> userInfoList) {
    return ListView.separated(
      controller: controller.scrollController,
      itemBuilder: (context, index) {
        return UserInfoWidget(userInfo: userInfoList[index]);
      },
      separatorBuilder: ((context, index) => const Divider(
            color: Colors.grey,
          )),
      itemCount: userInfoList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('setState 상태관리'),
      ),
      body: Obx(
          () => _userListWidget(controller.userInfoResult.value.userInfoList)),
    );
  }
}
