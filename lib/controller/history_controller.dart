import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_controller.dart';

class HistoryController extends GetxController {
  final TodoController todoController = Get.find<TodoController>();

  RxList<Todo> get completedTodos => todoController.history;

  var isMobile = true.obs;
  void updateLayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }

  void confirmRemoveFromHistory(Todo todo) {
    Get.defaultDialog(
      title: "Konfirmasi",
      middleText: "Apakah kamu yakin ingin menghapus todo ini dari riwayat?",
      textCancel: "Batal",
      textConfirm: "Hapus",
      confirmTextColor: Get.theme.colorScheme.onPrimary,
      onConfirm: () {
        todoController.history.remove(todo);
        Get.back();
        Get.snackbar(
          "Berhasil",
          "Todo berhasil dihapus dari history",
          snackPosition: SnackPosition.TOP,
        );
      },
    );
  }
}
