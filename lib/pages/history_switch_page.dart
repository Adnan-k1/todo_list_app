import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/controller/history_controller.dart';
import 'package:todo_list_app/pages/mobile/history_page.dart';
import 'package:todo_list_app/pages/widescreen/history_wide_page.dart';

class ExamplePage extends StatelessWidget {
  ExamplePage({super.key});

  final controller = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // detection width
          controller.updateLayout(constraints);
          // transforming load page
          return Obx(
            () => controller.isMobile.value ? HistoryPage() : HistoryWidePage(),
          );
        },
      ),
    );
  }
}
