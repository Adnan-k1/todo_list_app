import 'package:get/get.dart';

class Todo {
  String title;
  String description; // waktu start - end
  String status; // Upcoming, In Progress, Done
  int colorIndex;

  Todo({
    required this.title,
    required this.description,
    this.status = "Upcoming",
    this.colorIndex = 0,
  });
}

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  var history = <Todo>[].obs;

  void addTodo(String title, String description, int colorIndex) {
    if (title.isNotEmpty) {
      todos.add(
        Todo(
          title: title,
          description: description,
          colorIndex: colorIndex,
        ),
      );
    }
  }

  void updateStatus(int index, String newStatus) {
    todos[index].status = newStatus;

    if (newStatus == "Done") {
      // pindahkan ke history
      history.add(todos[index]);
      todos.removeAt(index);
    } else {
      todos.refresh();
    }
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
  }
}
