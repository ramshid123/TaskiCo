import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/common/color_constants.dart';
import 'package:todo_app/common/shared_pref_strings.dart';
import 'package:todo_app/models/category_model.dart';
import 'homepage_index.dart';

class HomePageController extends GetxController {
  HomePageController();
  final state = HomePageState();

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    final sf = await SharedPreferences.getInstance();
    state.name.value = sf.getString(SharedPrefStrings.name)!;
    state.profile_pic.value = sf.getString(SharedPrefStrings.avatar)!;
    state.isInitialized.value = true;
    await getCategoriesData();
    state.pageController.addListener(() {
      state.currentPageColorIndex.value =
          state.pageController.page!.round() % 6;
    });
  }

  Future deleteCategory({required String id}) async {
    final response = await CategoryModel.deleteCategory(id: id);
    if (response == false) {
      Get.showSnackbar(GetSnackBar(
        title: 'Oops!',
        message: 'Something went wrong',
        backgroundColor: Colors.red,
        duration: 3.seconds,
      ));
    }
    await getCategoriesData();
  }

  Future getCategoriesData() async {
    DateTime today = DateTime.now();
    today = DateTime(today.year, today.month, today.day);
    List itemsToRemove = [];

    List<CategoryModel> list = await CategoryModel.getData();
    for (var category in list) {
      for (var todoItem in category.todoList)
        if (todoItem.date.isBefore(today)) itemsToRemove.add(todoItem);
      for (var item in itemsToRemove) category.todoList.remove(item);
    }
    itemsToRemove.clear();
    
    await CategoryModel.updateAllCategories(list: list);
    state.data.value = await CategoryModel.getData();
    state.totalTasks.value = 0;
    for (var item in state.data) {
      state.totalTasks.value += (item.totalTasks - item.completedTasks);
    }
  }

  Future addCategory() async {
    if (state.formKey.currentState!.validate()) {
      state.isLoading.value = true;
      await Future.delayed(500.milliseconds);
      final status = await CategoryModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: state.titleCont.text,
        iconName: state.iconName.value,
        totalTasks: 0,
        completedTasks: 0,
        todoList: [],
      ).addCategory();

      if (status == false) {
        Get.showSnackbar(GetSnackBar(
          title: 'Oops!',
          message: 'Something went wrong',
          backgroundColor: Colors.red,
          duration: 3.seconds,
        ));
      }
      state.titleCont.clear();
      state.iconName.value = 'person';
      state.isLoading.value = false;
      await Future.delayed(500.milliseconds);
    }
    await getCategoriesData();
  }
}
