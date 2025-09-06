import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../controller/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    // Pastikan TodoController sudah tersedia
    Get.lazyPut<TodoController>(() => TodoController(), fenix: true);

    // Inject HistoryController
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
