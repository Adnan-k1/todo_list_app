import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Todo {
  String title;
  String description;
  String status;
  int colorIndex;
  String? startTime;
  String? endTime;

  Todo({
    required this.title,
    this.description = "",
    this.status = "Upcoming",
    this.colorIndex = 0,
    this.startTime,
    this.endTime,
  });

  @override
  String toString() {
    return "Todo(title: $title, desc: $description, status: $status, "
        "colorIndex: $colorIndex, start: $startTime, end: $endTime)";
  }
}

class TodoController extends GetxController {
  final todos = <Todo>[].obs;
  final history = <Todo>[].obs;

  var isMobile = true.obs;
  void updateLayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }

  void addTodo(String title, String description, int colorIndex) {
    if (title.trim().isNotEmpty) {
      todos.add(
        Todo(
          title: title.trim(),
          description: description.trim(),
          colorIndex: colorIndex,
        ),
      );
    }
  }

  /// Tambah todo pakai controller dari form
  void saveTodo({
    required TextEditingController titleCtrl,
    required TextEditingController startTimeCtrl,
    required TextEditingController endTimeCtrl,
  }) {
    if (titleCtrl.text.trim().isEmpty) return;

    todos.add(
      Todo(
        title: titleCtrl.text.trim(),
        description: "",
        startTime: startTimeCtrl.text.trim().isNotEmpty
            ? startTimeCtrl.text.trim()
            : null,
        endTime: endTimeCtrl.text.trim().isNotEmpty
            ? endTimeCtrl.text.trim()
            : null,
      ),
    );

    // Clear input field
    titleCtrl.clear();
    startTimeCtrl.clear();
    endTimeCtrl.clear();
  }

  /// Update status todo dan pindahkan ke history kalau sudah "Done"
  void updateStatus(int index, String newStatus) {
    if (index < 0 || index >= todos.length) return;

    final todo = todos[index];
    todo.status = newStatus;

    switch (newStatus) {
      case "Upcoming":
        todo.colorIndex = 0;
        break;
      case "In Progress":
        todo.colorIndex = 1;
        break;
      case "Done":
        todo.colorIndex = 2;
        break;
    }

    if (newStatus == "Done") {
      history.add(todo);

      // Hapus dari todo list setelah delay singkat (biar smooth)
      Future.delayed(const Duration(milliseconds: 200), () {
        if (index < todos.length && todos.contains(todo)) {
          todos.remove(todo);
        }
      });
    } else {
      todos.refresh(); // trigger UI update
    }
  }

  /// Hapus todo dari list utama
  void deleteTodo(int index) {
    if (index < 0 || index >= todos.length) return;
    todos.removeAt(index);
  }

  /// Hapus dari history
  void deleteFromHistory(int index) {
    if (index < 0 || index >= history.length) return;
    history.removeAt(index);
  }
}
