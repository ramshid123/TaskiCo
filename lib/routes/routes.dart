import 'package:get/route_manager.dart';
import 'package:todo_app/pages/add_task_page/addtaskpage_index.dart';
import 'package:todo_app/pages/home_page/homepage_index.dart';
import 'package:todo_app/pages/landing_page/binding.dart';
import 'package:todo_app/pages/landing_page/view.dart';
import 'package:todo_app/pages/splash_screen/splashscree_index.dart';
import 'package:todo_app/pages/todo_page/todopage_index.dart';
import 'package:todo_app/routes/names.dart';

class AppRoutes {
  static final List<GetPage> getPages = [
    GetPage(
      name: AppRouteNames.homePage,
      page: () => HomePage(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: AppRouteNames.todoPage,
      page: () => TodoPage(),
      binding: TodoPageBinding(),
    ),
    GetPage(
      name: AppRouteNames.addTaskPage,
      page: () => AddTaskPage(),
      binding: AddTaskPageBinding(),
    ),
    GetPage(
      name: AppRouteNames.landingPage,
      page: () => LandingPage(),
      binding: LandingPageBinding(),
    ),
    GetPage(
      name: AppRouteNames.splashScreen,
      page: () => SplashScreen(),
      binding: SplashScreenBinding(),
    ),
  ];
}
