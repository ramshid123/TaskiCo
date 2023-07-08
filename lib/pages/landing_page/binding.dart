import 'package:get/get.dart';
import 'landingpage_index.dart';


class LandingPageBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<LandingPageController>(LandingPageController());
  }
}
