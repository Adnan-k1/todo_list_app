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
    required this.description,
    this.status = "Upcoming",
    this.colorIndex = 0,
    this.startTime,
    this.endTime,
  });

  @override
  String toString() {
    return "Todo(title: $title, desc: $description, status: $status, colorIndex: $colorIndex, start: $startTime, end: $endTime)";
  }
}

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  var history = <Todo>[].obs;

  void addTodo(String title, String description, int colorIndex) {
    if (title.isNotEmpty) {
      todos.add(
        Todo(title: title, description: description, colorIndex: colorIndex),
      );
    }
  }

  void saveTodo({
    required TextEditingController titleCtrl,
    required TextEditingController startTimeCtrl,
    required TextEditingController endTimeCtrl,
  }) {
    if (titleCtrl.text.isEmpty) return;

    todos.add(
      Todo(
        title: titleCtrl.text,
        description: '',
        startTime: startTimeCtrl.text.isNotEmpty ? startTimeCtrl.text : null,
        endTime: endTimeCtrl.text.isNotEmpty ? endTimeCtrl.text : null,
      ),
    );

    titleCtrl.clear();
    startTimeCtrl.clear();
    endTimeCtrl.clear();
  }

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
      Future.delayed(const Duration(milliseconds: 100), () {
        if (index < todos.length) {
          todos.removeAt(index);
        }
      });
    } else {
      todos.refresh();
    }
  }

  void deleteTodo(int index) {
    if (index < 0 || index >= todos.length) return;
    todos.removeAt(index);
  }
}
