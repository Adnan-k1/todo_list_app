import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer'; // Import untuk logging
import '../routes/app_routes.dart';

class SplashscreenController extends GetxController {
  // Durasi minimum splash screen yang diinginkan
  final minDuration = const Duration(seconds: 2);

  @override
  void onInit() {
    super.onInit();

    // Panggil fungsi pengecekan status
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    log('--- Memulai pengecekan Login di Splash Screen ---');

    // Future 1: Dapatkan status login dari SharedPreferences
    final loginCheckFuture = _getLoginStatus();

    // Future 2: Tunggu durasi minimum splash screen
    final durationFuture = Future.delayed(minDuration);

    // Menunggu kedua Future selesai: (Durasi minimum AND Pembacaan status)
    await Future.wait([loginCheckFuture, durationFuture]);

    // Setelah kedua future selesai, ambil hasil status login
    final isLoggedIn = await loginCheckFuture;

    log('Status isLoggedIn yang dibaca: $isLoggedIn');

    if (isLoggedIn) {
      log('Status TRUE: Mengarahkan ke Dashboard.');
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      log('Status FALSE: Mengarahkan ke Login Page.');
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<bool> _getLoginStatus() async {
    log('Mencoba membaca status dari SharedPreferences...');
    // Memberikan sedikit waktu tunggu untuk memastikan SharedPreferences siap
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
      return isLoggedIn;
    } catch (e) {
      log('Error reading SharedPreferences: $e');
      return false;
    }
  }
}
