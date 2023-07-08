import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPageState {
  final formKey = GlobalKey<FormState>();

  var selectedAvatarIndex = 0.obs;

  final nameCont = TextEditingController();

  var toNextPage = false.obs;

  final avatarToNameMap = {
    0: 'assets/man.png',
    1: 'assets/women.png',
    2: 'assets/boy.png',
    3: 'assets/girl.png',
  };
}
