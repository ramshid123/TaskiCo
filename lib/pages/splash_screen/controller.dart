import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/common/shared_pref_strings.dart';
import 'package:todo_app/routes/names.dart';
import 'splashscree_index.dart';

class SplashScreenController extends GetxController {
  SplashScreenController();
  final state = SplashScreenState();

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    final sf = await SharedPreferences.getInstance();
    final isItFirstTime = sf.getString(SharedPrefStrings.isItFirstTime);
    await Future.delayed(1.seconds);
    state.isInitialized.value = true;
    await Future.delayed(1.seconds);
    if (isItFirstTime == null)
      await Get.offAllNamed(AppRouteNames.landingPage);
    else
      await Get.offAllNamed(AppRouteNames.homePage);
  }
}
