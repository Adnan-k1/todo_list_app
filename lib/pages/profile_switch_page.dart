import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/controller/profile_controller.dart';
import 'package:todo_list_app/pages/mobile/profile_page.dart';
import 'package:todo_list_app/pages/widescreen/profile_wide_page.dart';

class ProfileSwitchPage extends StatelessWidget {
  ProfileSwitchPage({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // detection width
          controller.updateLayout(constraints);
          // transforming load page
          return Obx(
            () => controller.isMobile.value ? ProfilePage() : ProfileWidePage(),
          );
        },
      ),
    );
  }
}
