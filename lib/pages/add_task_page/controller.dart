import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/category_model.dart';
import 'addtaskpage_index.dart';

class AddTaskPageController extends GetxController {
  AddTaskPageController();
  final state = AddTaskPageState();

  String determineDate() {
    if (isToday(state.selectedDate.value!, DateTime.now()))
      return 'Today';
    else if (isTomorrow(state.selectedDate.value!, DateTime.now()))
      return 'Tomorrow';
    else {
      return DateFormat.yMMMd().format(state.selectedDate.value!);
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

  Future addTodoItem({required String id}) async {
    state.selectedDate.value = DateTime(state.selectedDate.value!.year,state.selectedDate.value!.month,state.selectedDate.value!.day);
    final response = await CategoryModel.addTodoItem(
        name: state.textCont.text, date: state.selectedDate.value!, id: id);
    if (response == false) {
      Get.showSnackbar(GetSnackBar(
        title: 'Oops!',
        message: 'Something went wrong',
        backgroundColor: Colors.red,
        duration: 3.seconds,
      ));
    } else {
      state.focusNode.unfocus();
      await Future.delayed(100.milliseconds);
      state.popScope.value = true;
      await Future.delayed(500.milliseconds);
      Get.back();
    }
  }
}
