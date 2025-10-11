import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/components/todo_card.dart';
import 'package:todo_list_app/controller/todo_controller.dart';

class HomeWidePage extends GetView<TodoController> {
  const HomeWidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.todos.isEmpty) {
          return const Center(child: Text("Belum ada todo"));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 800) {
              crossAxisCount = 2;
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3,
              ),
              itemCount: controller.todos.length,
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
