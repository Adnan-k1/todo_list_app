import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../controller/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoController>(() => TodoController(), fenix: true);
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
