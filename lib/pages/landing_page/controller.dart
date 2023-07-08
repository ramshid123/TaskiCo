import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/common/shared_pref_strings.dart';
import 'package:todo_app/pages/home_page/homepage_index.dart';
import 'package:todo_app/routes/names.dart';
import 'landingpage_index.dart';

class LandingPageController extends GetxController {
  LandingPageController();
  final state = LandingPageState();

  Future proceedToNextPage() async {
    if (state.formKey.currentState!.validate()) {
      final sf = await SharedPreferences.getInstance();
      await sf.setString(SharedPrefStrings.avatar,
          state.avatarToNameMap[state.selectedAvatarIndex.value]!);
      await sf.setString(SharedPrefStrings.name, state.nameCont.text);
      await sf.setString(SharedPrefStrings.isItFirstTime, 'yoohoo');
      state.toNextPage.value = true;
      await Future.delayed(1000.milliseconds);
      Get.offAll(
        () => HomePage(),
        binding: HomePageBinding(),
        routeName: AppRouteNames.homePage,
        duration: 200.milliseconds,
        curve: Curves.easeInOut,
      );
    }
  }
}
