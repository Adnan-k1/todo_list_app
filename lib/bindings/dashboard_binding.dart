import 'package:get/get.dart';
import 'package:todo_list_app/controller/user_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
      Get.lazyPut<UserController>(() => UserController());
  }
}