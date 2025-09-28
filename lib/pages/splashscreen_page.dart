import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/splashscreen_controller.dart';

class SplashscreenPage extends StatelessWidget {
  const SplashscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashscreenController());

    return const Scaffold(
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
