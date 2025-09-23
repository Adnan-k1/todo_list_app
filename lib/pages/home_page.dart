import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../components/todo_card.dart';

class HomePage extends GetView<TodoController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.todos.isEmpty) {
          return const Center(child: Text("Belum ada todo"));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.todos.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return TodoCard(
              todo: todo,
              onStatusChanged: (val) {
                if (val != null) controller.updateStatus(index, val);
              },
              showDelete: false, 
              enableDropdown: true, 
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-todo'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
