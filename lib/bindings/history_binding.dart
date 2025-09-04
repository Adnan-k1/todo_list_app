import 'package:get/get.dart';
import '/controller/history_controller.dart';
import '/controller/todo_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    // Pastikan TodoController sudah ada karena HistoryController butuh reference ke TodoController
    if (!Get.isRegistered<TodoController>()) {
      Get.put(TodoController());
    }
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
