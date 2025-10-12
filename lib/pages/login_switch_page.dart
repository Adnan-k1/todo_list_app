import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_app/controller/auth_controller.dart';
// Perbarui path impor sesuai struktur folder yang Anda tunjukkan
import 'package:todo_list_app/pages/mobile/login_page.dart';
import 'package:todo_list_app/pages/widescreen/login_wide_page.dart';

class LoginSwitchPage extends StatelessWidget {
  const LoginSwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Pastikan AuthController terdaftar
    if (!Get.isRegistered<AuthController>()) {
      Get.put(AuthController());
    }

    // Mendapatkan instance controller yang sudah diinisialisasi
    // Ini diperlukan karena LoginSwitchPage sekarang adalah StatelessWidget, bukan GetView.
    final controller = Get.find<AuthController>();

    // 2. Gunakan Scaffold dengan latar belakang yang sama
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 3. Perbarui state responsif di controller
            controller.updateLayout(constraints);

            // 4. Dengarkan perubahan state dan tampilkan UI yang sesuai
            return Obx(() {
              // Jika isMobile true (lebar < 600)
              if (controller.isMobile.value) {
                // Mengganti LoginMobilePage menjadi LoginPage sesuai impor baru
                return const LoginPage(); 
              } else {
                // Jika isMobile false (lebar >= 600)
                return const LoginWidePage();
              }
            });
          },
        ),
      ),
    );
  }
}
