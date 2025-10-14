import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class UserController extends GetxController {
  static const String loginRoute = '/login'; 

  // Fungsi logout — hapus semua data di SharedPreferences
  Future<void> logout() async {
    log('--- Memulai proses Logout ---');
    final prefs = await SharedPreferences.getInstance();
    
    // Hapus semua data pengguna
    await prefs.clear(); 
    log('Semua data SharedPreferences berhasil dihapus.');

    // Navigasi ke halaman login dan hapus semua route sebelumnya
    Get.offAllNamed(loginRoute);

    log('Aplikasi diarahkan ke halaman Login.');
  }
}
