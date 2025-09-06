import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String dummyUsername = "arza";
  final String dummyPassword = "gian";

  void login(BuildContext context) {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username == dummyUsername && password == dummyPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Login Berhasil"),
          backgroundColor: Colors.green, // sukses -> hijau
          behavior: SnackBarBehavior.floating,
        ),
      );
      Get.offAllNamed('/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ Username / Password salah"),
          backgroundColor: Colors.red, // gagal -> merah
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void logout() {
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
