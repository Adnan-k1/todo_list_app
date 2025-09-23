import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import 'home_page.dart';
import 'history_page.dart';
import 'profile_page.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_drawer.dart';

class DashboardPage extends GetView<HomeController> {
  final pages = [HomePage(), HistoryPage(), ProfilePage()];
  final pageTitles = ["Today Task's", "History", "Profile"];

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppBar(
          title: pageTitles[controller.currentIndex.value],
        ),
        drawer: CustomDrawer(
          onPageSelected: (index) {
            controller.changePage(index);
            Get.back();
          },
        ),
        body: Container(
          color: Colors.grey.shade100,
          child: pages[controller.currentIndex.value],
        ),
      ),
    );
  }
}
