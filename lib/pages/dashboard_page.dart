import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import 'home_page.dart';
import 'history_page.dart';
import 'profile_page.dart';

class DashboardPage extends GetView<HomeController> {
  final pages = [HomePage(), HistoryPage(), ProfilePage()];
  final pageTitles = ["Home", "History", "Profile"]; // Judul dinamis

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            pageTitles[controller.currentIndex.value],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("ArzaGian"),
                accountEmail: Text("arzaadnansumaryo@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                  controller.changePage(0);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text("History"),
                onTap: () {
                  controller.changePage(1);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {
                  controller.changePage(2);
                  Get.back();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),

        body: Container(
          color: Colors.grey.shade100,
          child: pages[controller.currentIndex.value],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Apakah Anda yakin ingin keluar?",
      textCancel: "Batal",
      textConfirm: "Logout",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.offAllNamed("/login");
      },
    );
  }
}
