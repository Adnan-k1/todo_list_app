import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Asumsi Anda memiliki AppRoutes, jika tidak, ganti dengan navigasi hardcode
// import '../routes/app_routes.dart'; 

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final String dummyUsername = "arza";
  final String dummyPassword = "gian";

  // State untuk visibilitas password
  var isPasswordHidden = true.obs;
  
  // State untuk tata letak responsif (true jika lebar < 600)
  var isMobile = true.obs;

  // Metode yang dipanggil oleh LayoutBuilder untuk memperbarui state responsif
  void updateLayout(BoxConstraints constraints) {
    // 600 adalah breakpoint standar untuk beralih dari mobile ke tablet/desktop
    isMobile.value = constraints.maxWidth < 600;
  }

  void login(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username == dummyUsername && password == dummyPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Login Berhasil"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Navigasi ke dashboard (Ganti dengan Get.offAllNamed(AppRoutes.dashboard) jika tersedia)
      print("DEBUG: Navigasi ke Dashboard"); 
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
