import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/splash_screen/controller.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Center(
          child: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Image.asset('assets/todo_icon.png'),
          )
              .animate(delay: 100.ms)
              .moveX(
                  begin: Get.width,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic)
              .animate(target: controller.state.isInitialized.value ? 1 : 0)
              .moveX(
                  end: -Get.width, duration: 500.ms, curve: Curves.easeInCubic),
        ),
      );
    });
  }
}
