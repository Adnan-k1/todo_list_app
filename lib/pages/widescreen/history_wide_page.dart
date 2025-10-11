import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/components/todo_card.dart';
import 'package:todo_list_app/controller/history_controller.dart';

class HistoryWidePage extends GetView<HistoryController> {
  const HistoryWidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6F9),
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF7ACFB0),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.completedTodos.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada riwayat todo",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          );
        }

        // Dapatkan lebar layar
        final screenWidth = MediaQuery.of(context).size.width;
        int crossAxisCount = 1;
        double aspectRatio = 2.8;

        // Atur kolom berdasarkan ukuran layar
        if (screenWidth > 1200) {
          crossAxisCount = 3;
          aspectRatio = 3;
        } else if (screenWidth > 800) {
          crossAxisCount = 2;
          aspectRatio = 2.5;
        }

        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1300),
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: controller.completedTodos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (context, index) {
                final todo = controller.completedTodos[index];
                return TodoCard(
                  todo: todo,
                  onDelete: () => controller.confirmRemoveFromHistory(todo),
                  showDelete: true,
                  enableDropdown: false,
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
