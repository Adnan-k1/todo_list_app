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

 
  void login(BuildContext context) async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username == dummyusername && password == dummypassword) {
      
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

  Future<void> logout() async {
    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Apakah Anda yakin ingin logout?",
      textCancel: "Batal",
      textConfirm: "Logout",
      confirmTextColor: Colors.white,
      onConfirm: () async {

        final prefs = await SharedPreferences.getInstance();
        await prefs.remove("isLoggedIn");

     
        Get.offAllNamed(AppRoutes.login);
      },
    );
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

  void updateLayout(BoxConstraints constraints) {
    if (constraints.maxWidth > 600) {
      isMobile.value = false; 
    } else {
      isMobile.value = true; 
    }
  }
}
