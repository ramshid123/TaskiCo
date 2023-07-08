import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskPageState {
  var popScope = false.obs;
  final textCont = TextEditingController();
  final focusNode = FocusNode();

  Rx<DateTime?> selectedDate = DateTime.now().obs;
}
