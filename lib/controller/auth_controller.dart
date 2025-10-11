import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String dummyusername = "arza";
  final String dummypassword = "gian";

  var isPasswordHidden = true.obs;

  var isMobile = true.obs;
  void updateLayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }

  void login(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username == dummyusername && password == dummypassword) {
      // 1. Simpan status login ke TRUE
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Login Berhasil"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Username / Password salah"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();

    // *** PERUBAHAN KRUSIAL: Hapus kunci secara total dan pastikan penghapusan berhasil.
    final bool removed = await prefs.remove("isLoggedIn");

    // Logging untuk debug:
    print('DEBUG LOGOUT: Status isLoggedIn berhasil dihapus? $removed');

    // Tingkatkan penundaan menjadi 1.5 detik untuk memastikan I/O disk selesai.
    await Future.delayed(const Duration(milliseconds: 1500));

    Get.snackbar(
      "Logout Berhasil",
      "Anda telah berhasil keluar dari akun.",
      backgroundColor: Colors.yellow.shade100,
      colorText: Colors.black87,
    );

    // Navigasi setelah data dipastikan terhapus
    Get.offAllNamed(AppRoutes.login);
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
