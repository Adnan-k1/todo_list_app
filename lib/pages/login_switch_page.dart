import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/controller/auth_controller.dart';
import 'package:todo_list_app/pages/mobile/login_page.dart';
import 'package:todo_list_app/pages/widescreen/login_wide_page.dart';

class LoginSwitchPage extends StatelessWidget {
  LoginSwitchPage({super.key});

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          controller.updateLayout(constraints);

          return Obx(
            () => controller.isMobile.value ? LoginPage() : LoginWidePage(),
          );
        },
      ),
    );
  }
}
