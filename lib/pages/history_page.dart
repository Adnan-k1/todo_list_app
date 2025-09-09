import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/history_controller.dart';
import '../components/todo_card.dart';

class HistoryPage extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.completedTodos.length,
          itemBuilder: (context, index) {
            final todo = controller.completedTodos[index];
            return TodoCard(
              todo: todo,
              onDelete: () => controller.removeFromHistory(todo),
              onStatusChanged: (status) {
                todo.status = status ?? todo.status;
                controller.update();
              },
            );
          },
        ),
      ),
    );
  }
}
