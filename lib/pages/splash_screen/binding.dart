import 'package:get/get.dart';
import 'splashscree_index.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<SplashScreenController>(SplashScreenController());
  }
}
