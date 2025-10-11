import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/history_controller.dart';
import '../../components/todo_card.dart';

class HistoryPage extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.completedTodos.isEmpty) {
          return const Center(child: Text("Belum ada riwayat todo"));
        }
        return ListView.builder(
          itemCount: controller.completedTodos.length,
          itemBuilder: (context, index) {
            final todo = controller.completedTodos[index];
            return TodoCard(
              todo: todo,
              onDelete: () => controller.confirmRemoveFromHistory(todo),
              showDelete: true,
              enableDropdown: false,
            );
          },
        );
      }),
    );
  }
}
