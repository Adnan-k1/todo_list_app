import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String dummyUsername = "arza";
  final String dummyPassword = "gian";

  void login(BuildContext context) {
    if (usernameController.text == dummyUsername &&
        passwordController.text == dummyPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Berhasil")));

      Get.offAllNamed('/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username / Password salah")),
      );
    }
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}
