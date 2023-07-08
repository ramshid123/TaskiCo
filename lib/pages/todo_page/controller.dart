import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/category_model.dart';
import 'package:todo_app/models/todo_item_model.dart';
import 'todopage_index.dart';

class TodoPageController extends GetxController {
  TodoPageController();
  final state = TodoPageState();

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await getCategoryData();
    await seperateAlongDate();
  }

  String determineDate({required DateTime date}) {
    if (isToday(date, DateTime.now()))
      return 'Today';
    else if (isTomorrow(date, DateTime.now()))
      return 'Tomorrow';
    else {
      return DateFormat.yMMMd().format(date);
    }
  }

  bool isTomorrow(DateTime dateToCheck, DateTime currentDate) {
    DateTime tomorrow = currentDate.add(Duration(days: 1));
    return dateToCheck.year == tomorrow.year &&
        dateToCheck.month == tomorrow.month &&
        dateToCheck.day == tomorrow.day;
  }

  bool isToday(DateTime dateToCheck, DateTime currentDate) {
    return dateToCheck.year == currentDate.year &&
        dateToCheck.month == currentDate.month &&
        dateToCheck.day == currentDate.day;
  }

  Future getCategoryData() async {
    state.isVariablesLoading.value = true;
    state.categoryData.value =
        await CategoryModel.getSingleData(id: Get.arguments['id']);
    state.isVariablesLoading.value = false;
    update();
  }

  Future seperateAlongDate() async {
    Set<DateTime> dates = {};
    state.todoList.clear();
    for (TodoItemModel todoItem in state.categoryData.value.todoList) {
      dates.add(todoItem.date);
    }

    int i = 0;
    for (var date in dates) {
      state.todoList.add([date, []]);
      for (var item in state.categoryData.value.todoList) {
        if (item.date == date) {
          state.todoList[i][1].add(item);
        }
      }
      i++;
    }
  }

  Future updateTodoList(
      {required int i, required int j, required bool? val}) async {
    state.todoList[i][1][j].isDone = val!;

    List<TodoItemModel> list = [];

    for (var item in state.todoList)
      for (var subItem in item[1]) list.add(subItem);
    state.categoryData.value.todoList = list;
    val
        ? state.categoryData.value.completedTasks++
        : state.categoryData.value.completedTasks--;

    await CategoryModel.updateCategory(categoryModel: state.categoryData.value);

    update();
  }
}
