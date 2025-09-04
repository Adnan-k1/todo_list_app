import 'package:get/get.dart';
import 'todo_controller.dart';

class HistoryController extends GetxController {
  final TodoController todoController = Get.find<TodoController>();

  var completedTodos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();

    ever(todoController.todos, (_) {
      completedTodos.value = todoController.todos
          .where((t) => t.isDone)
          .toList();
    });
  }
}
