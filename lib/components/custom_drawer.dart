import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart'; 

class CustomDrawer extends StatelessWidget {
  final Function(int) onPageSelected;

  const CustomDrawer({super.key, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "ArzaGian",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            accountEmail: const Text(
              "arzaaaaadnansumaryo@gmail.com",
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB3E5FC), Color(0xFFEFF6F9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          _drawerItem(
            Icons.home,
            "Today's task",
            () {
              onPageSelected(0);
              Get.back();
            },
            color: Colors.blue,
          ),
          _drawerItem(
            Icons.history,
            "History",
            () {
              onPageSelected(1);
              Get.back();
            },
            color: Colors.orange,
          ),
          _drawerItem(
            Icons.person,
            "Profile",
            () {
              onPageSelected(2);
              Get.back();
            },
            color: Colors.green,
          ),
          const Divider(),
          _drawerItem(
            Icons.logout,
            "Logout",
            () {
              Get.defaultDialog(
                title: "Konfirmasi Logout",
                middleText: "Apakah Anda yakin ingin keluar?",
                textCancel: "Batal",
                textConfirm: "Logout",
                confirmTextColor: Colors.white,
                onConfirm: () async {
                  // Tutup dialog dulu
                  Get.back();

                  // Jalankan logout (hapus semua data dan navigasi)
                  await userController.logout();

                  // Tampilkan snackbar notifikasi
                  Get.snackbar(
                    "Logout Berhasil",
                    "Anda telah keluar dari akun.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.blueAccent.withOpacity(0.2),
                    colorText: Colors.black,
                    margin: const EdgeInsets.all(10),
                    borderRadius: 10,
                  );
                },
              );
            },
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
