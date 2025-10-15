import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class UserController extends GetxController {
  static const String loginRoute = '/login'; 

  
  Future<void> logout() async {
    log('--- Memulai proses Logout ---');
    final prefs = await SharedPreferences.getInstance();
   
    await prefs.clear(); 
    log('Semua data SharedPreferences berhasil dihapus.');

   
    Get.offAllNamed(loginRoute);

    log('Aplikasi diarahkan ke halaman Login.');
  }
}