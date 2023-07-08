import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/category_model.dart';
import 'package:todo_app/models/todo_item_model.dart';
import 'package:todo_app/routes/names.dart';
import 'package:todo_app/routes/routes.dart';

void main(List<String> args) async {
  await initHive();
  // await deleteDB();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
        Animate.restartOnHotReload = true;

    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, _) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'TaskiCo',
            initialRoute: AppRouteNames.splashScreen,
            getPages: AppRoutes.getPages,
          );
        });
  }
}

Future initHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId))
    Hive.registerAdapter(CategoryModelAdapter());

  if (!Hive.isAdapterRegistered(TodoItemModelAdapter().typeId))
    Hive.registerAdapter(TodoItemModelAdapter());
}

Future deleteDB() async {
  final box = await Hive.openBox<CategoryModel>('categories');
  await box.deleteFromDisk();
}

Future hiveTest() async {
  final box = await Hive.openBox<CategoryModel>('categories');
  for (int i = 0; i < box.length; i++) {
    final todoList = box.getAt(i)!.todoList;
    todoList.forEach((element) {
      print('${element.name}   ----   ${element.date}');
    });
  }
}
