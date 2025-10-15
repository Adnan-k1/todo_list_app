import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import '../routes/app_routes.dart';

class SplashscreenController extends GetxController {
  final Duration minDuration = const Duration(seconds: 2);

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    log('--- Memulai pengecekan Login di Splash Screen ---');

    final prefs = await SharedPreferences.getInstance();


    await Future.delayed(minDuration);

    final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    log('Status isLoggedIn yang dibaca: $isLoggedIn');

    if (isLoggedIn) {
      log('Status TRUE: Mengarahkan ke Dashboard.');
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      log('Status FALSE: Mengarahkan ke Login Page.');
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
