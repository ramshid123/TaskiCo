import 'package:get/get.dart';
import 'package:todo_app/models/category_model.dart';
import 'package:todo_app/models/todo_item_model.dart';

class TodoPageState {
  var willPopscope = false.obs;

  Rx<CategoryModel> categoryData = CategoryModel(
      id: '',
      name: '',
      iconName: '',
      totalTasks: 1,
      completedTasks: 0,
      todoList: []).obs;

  var isVariablesLoading = true.obs;

  RxList todoList = [].obs;
}
