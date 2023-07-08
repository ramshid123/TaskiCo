import 'package:get/get.dart';
import 'todopage_index.dart';


class TodoPageBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<TodoPageController>(TodoPageController());
  }
}
