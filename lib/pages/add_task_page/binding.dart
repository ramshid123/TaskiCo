import 'package:get/get.dart';
import 'addtaskpage_index.dart';


class AddTaskPageBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<AddTaskPageController>(AddTaskPageController());
  }
}
