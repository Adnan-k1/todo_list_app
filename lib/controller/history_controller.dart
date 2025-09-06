import 'package:get/get.dart';
import 'todo_controller.dart';

class HistoryController extends GetxController {
  final TodoController todoController = Get.find<TodoController>();

  RxList<Todo> get completedTodos => todoController.history;
}
