import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo_controller.dart'; // Pastikan path ini benar (berisi class Todo dan TodoController)

class HistoryController extends GetxController {
  // Mengambil instance TodoController yang sudah diinisialisasi
  final TodoController todoController = Get.find<TodoController>();

  // Menggunakan getter untuk mengakses list history dari TodoController
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
        // 1. Hapus dari database melalui TodoController
        // Kita perlu mencari index todo ini di list history (karena todoController.deleteFromHistory 
        // menerima index, bukan objek Todo).
        final index = todoController.history.indexOf(todo);
        
        if (index != -1) {
          // Panggil metode delete dari TodoController untuk menghapus dari DB dan List GetX
          todoController.deleteFromHistory(index); 
          
          Get.back();
          Get.snackbar(
            "Berhasil",
            "Todo berhasil dihapus dari history dan database",
            snackPosition: SnackPosition.TOP,
          );
        } else {
          Get.back();
          Get.snackbar(
            "Gagal",
            "Todo tidak ditemukan dalam history.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
    );
  }
}