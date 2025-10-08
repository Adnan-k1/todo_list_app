import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import '../routes/app_routes.dart';

class SplashscreenController extends GetxController {
  final minDuration = const Duration(seconds: 2);

  var isMobile = true.obs;
  void updateLayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }

  @override
  void onInit() {
    super.onInit();

    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    log('--- Memulai pengecekan Login di Splash Screen ---');

    final loginCheckFuture = _getLoginStatus();

    final durationFuture = Future.delayed(minDuration);

    await Future.wait([loginCheckFuture, durationFuture]);

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

    await Future.delayed(const Duration(seconds: 4));
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
