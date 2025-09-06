import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';

class HomePage extends GetView<TodoController> {
  const HomePage({super.key});

  Color _getCardColor(String status) {
    switch (status) {
      case "Done":
        return const Color(0xFFD1C4E9);
      case "In Progress":
        return const Color(0xFFB3E5FC);
      case "Upcoming":
        return const Color(0xFFC8E6C9);
      default:
        return Colors.grey.shade200;
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Tasks"),
        centerTitle: true,
      ),
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
            return Container(
              decoration: BoxDecoration(
                color: _getCardColor(todo.status),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    todo.description,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 8),

                  // Status dengan Dropdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: todo.status,
                        items: ["Upcoming", "In Progress", "Done"]
                            .map((s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(s),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            controller.updateStatus(index, val);
                          }
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                        
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          todo.status,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add-todo');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
