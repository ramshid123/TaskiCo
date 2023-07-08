import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:todo_app/models/category_model.dart';

class HomePageState {
  PageController pageController = PageController(viewportFraction: 0.8);
  var currentPageColorIndex = 0.obs;

  var name = ''.obs;
  var profile_pic = ''.obs;

  var isLoading = false.obs;

  var totalTasks = 0.obs;

  var createCategoryButtonTrigger = false.obs;

  var isInitialized = false.obs;

  var titleCont = TextEditingController();
  var iconName = 'person'.obs;
  var formKey = GlobalKey<FormState>();
  RxList<CategoryModel> data = <CategoryModel>[].obs;
}
