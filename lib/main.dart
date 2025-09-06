import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/auth_binding.dart';
import 'bindings/home_binding.dart';
import 'bindings/todo_binding.dart';
import 'bindings/history_binding.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/add_todo_page.dart';

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
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/dashboard',
          page: () => DashboardPage(),
          bindings: [
            HomeBinding(),
            TodoBinding(),
            HistoryBinding(),
          ],
        ),
        GetPage(
          name: '/add-todo',
          page: () => AddTodoPage(),
          binding: TodoBinding(),
        ),
      ],
    );
  }
}
