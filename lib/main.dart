import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/login_page.dart';
//import 'pages/dashboard_page.dart';
import 'bindings/auth_binding.dart';
import 'bindings/home_binding.dart';
import 'bindings/todo_binding.dart';
import 'bindings/history_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List App',
      initialRoute: '/login',
      getPages: [
        // Login Page
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          binding: AuthBinding(), // inject AuthController
        ),
        // Dashboard Page
        //GetPage(
        // name: '/dashboard',
        //page: () => DashboardPage(),
        // bindings: [
        // HomeBinding(), // inject HomeController
        // TodoBinding(), // inject TodoController
        // HistoryBinding(), // inject HistoryController
        // ],
        // ),
      ],
    );
  }
}
