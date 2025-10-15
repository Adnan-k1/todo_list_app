import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/controller/todo_controller.dart';
import 'package:todo_list_app/pages/mobile/home_page.dart';
import 'package:todo_list_app/pages/widescreen/home_wide_page.dart';

class HomeSwitchPage extends StatelessWidget {
  HomeSwitchPage({super.key});

  final controller = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          controller.updateLayout(constraints);

          return Obx(
            () => controller.isMobile.value ? HomePage() : HomeWidePage(),
          );
        },
      ),
    );
  }
}
