import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splashscreen_controller.dart';

class SplashscreenPage extends StatelessWidget {
  const SplashscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashscreenController());
    final screenHeight = Get.height;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF6F9), 
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7ACFB0), Color(0xFFEFF6F9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Icon(
                Icons.task_alt,
                size: screenHeight * 0.12,
                color: const Color(0xFF7ACFB0),
              ),
            ),

            const SizedBox(height: 28),

            
            const Text(
              "MY TODO LIST APP",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2F4858), // biru tua elegan
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 10),

            
            Text(
              "Mengelola Tugas, Setiap Hari.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),

            SizedBox(height: screenHeight * 0.15),

           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.white.withOpacity(0.4),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF7ACFB0),
                ),
                minHeight: 5,
                borderRadius: BorderRadius.circular(50),
              ),
            ),

            const SizedBox(height: 16),

           
            Text(
              "Memuat data...",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
