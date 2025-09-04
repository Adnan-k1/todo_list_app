import 'package:get/get.dart';

class Todo {
  String title;
  String description;
  String category;
  bool isDone;

  Todo({
    required this.title,
    required this.description,
    required this.category,
    this.isDone = false,
  });
}

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  void addTodo(String title, String description, String category) {
    if (title.isNotEmpty && description.isNotEmpty && category.isNotEmpty) {
      todos.add(
        Todo(title: title, description: description, category: category),
      );
    }
  }

  void toggleTodo(int index) {
    todos[index].isDone = !todos[index].isDone;
    todos.refresh();
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
  }
}
