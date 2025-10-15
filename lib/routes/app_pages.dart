import 'package:get/get.dart';
import 'package:todo_list_app/bindings/dashboard_binding.dart';
import 'package:todo_list_app/bindings/splashscreen_binding.dart';
import 'package:todo_list_app/pages/login_switch_page.dart';
import 'package:todo_list_app/pages/splashscreen_page.dart';
import '../bindings/auth_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/todo_binding.dart';
import '../bindings/history_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/dashboard_binding.dart';
import '../pages/login_switch_page.dart';
import '../pages/history_switch_page.dart';
import '../pages/home_switch_page.dart';
import '../pages/profile_switch_page.dart';
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
      page: () => LoginSwitchPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardPage(),
      bindings: [
        DashboardBinding(), 
        HomeBinding(),
        TodoBinding(),
        HistoryBinding(),
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.addTodo,
      page: () => AddTodoPage(),
      binding: TodoBinding(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => HistorySwitchPage(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeSwitchPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.splashscreen,
      page: () => SplashscreenPage(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileSwitchPage(),
      binding: ProfileBinding(),
    ),
  ];
}
