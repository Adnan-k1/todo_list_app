import 'package:get/get.dart';
import 'package:todo_list_app/bindings/splashscreen_binding.dart';
import 'package:todo_list_app/pages/splashscreen_page.dart';
import '../bindings/auth_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/todo_binding.dart';
import '../bindings/history_binding.dart';
import '../pages/mobile/login_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/add_todo_page.dart';
import '../pages/mobile/history_page.dart';
import '../pages/mobile/home_page.dart';
import '../pages/mobile/profile_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
      bindings: [HomeBinding(), TodoBinding(), HistoryBinding()],
    ),
    GetPage(
      name: AppRoutes.addTodo,
      page: () => AddTodoPage(),
      binding: TodoBinding(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => HistoryPage(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.splashscreen,
      page: () => SplashscreenPage(),
      binding: SplashscreenBinding(),
    ),
    GetPage(name: AppRoutes.profile, page: () => ProfilePage()),
  ];
}
