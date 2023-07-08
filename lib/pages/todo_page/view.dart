import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:todo_app/common/color_constants.dart';
import 'package:todo_app/common/common_widgets.dart';
import 'package:todo_app/pages/add_task_page/addtaskpage_index.dart';
import 'package:todo_app/pages/todo_page/controller.dart';
import 'package:todo_app/routes/names.dart';

class TodoPage extends GetView<TodoPageController> {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Animate.restartOnHotReload = false;

    return WillPopScope(
      onWillPop: () async {
        controller.state.willPopscope.value = true;
        await Future.delayed(600.ms);
        return true;
      },
      child: GetBuilder(
          init: controller,
          builder: (controller) {
            return Obx(() {
              return Scaffold(
                backgroundColor: Colors.transparent,
                floatingActionButton: GestureDetector(
                  onTap: () async => await Get.to(
                    () => AddTaskPage(),
                    routeName: AppRouteNames.addTaskPage,
                    binding: AddTaskPageBinding(),
                    duration: 1000.ms,
                    transition: Transition.fadeIn,
                    arguments: {
                      'id': Get.arguments['id'],
                      'colorIndex': Get.arguments['colorIndex'],
                      'icon': Get.arguments['icon'],
                      'name': Get.arguments['name'],
                    },
                  )!
                      .then((value) async {
                    await controller.getCategoryData();
                    await controller.seperateAlongDate();
                  }),
                  child: Hero(
                    tag: 'fab',
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: ColorConstants
                            .gradientList[Get.arguments['colorIndex']],
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 35.sp,
                      ),
                    )
                        .animate()
                        .scale(
                          delay: 1000.ms,
                          duration: 1000.ms,
                          begin: Offset(0, 0),
                          curve: Curves.bounceOut,
                        )
                        .animate(
                            target: controller.state.willPopscope.value ? 1 : 0)
                        .scale(
                          duration: 500.ms,
                          end: Offset(0, 0),
                          curve: Curves.bounceIn,
                        ),
                  ),
                ),
                body: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Hero(
                      tag: '${Get.arguments['index']} container',
                      child: AnimatedContainer(
                        duration: 1000.ms,
                        height: Get.height,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: SizedBox(
                        height: Get.height,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      controller.state.willPopscope.value =
                                          true;
                                      await Future.delayed(600.ms);
                                      Get.back();
                                    },
                                    icon: Icon(Icons.arrow_back),
                                    padding: EdgeInsets.zero,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert_rounded,
                                      color: Colors.grey.shade500,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                              kHeight(30.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.w),
                                child: SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onVerticalDragUpdate: (details) async {
                                          if (!details
                                              .delta.direction.isNegative) {
                                            controller.state.willPopscope
                                                .value = true;
                                            await Future.delayed(600.ms);
                                            Get.back();
                                          }
                                        },
                                        child: SizedBox(
                                          width: Get.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Hero(
                                                tag:
                                                    '${Get.arguments['index']} icon',
                                                child: Container(
                                                  height: 40.h,
                                                  width: 40.w,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 2.w),
                                                  ),
                                                  child: IconTheme(
                                                    data: IconThemeData(
                                                        color: Colors.white),
                                                    child: ShaderMask(
                                                      shaderCallback: (bounds) =>
                                                          ColorConstants
                                                              .gradientList[Get
                                                                      .arguments[
                                                                  'colorIndex']]
                                                              .createShader(
                                                                  Rect.fromLTRB(
                                                                      4,
                                                                      3,
                                                                      12,
                                                                      8)),
                                                      child: Icon(
                                                        Get.arguments['icon'],
                                                        size: 20.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              kHeight(20.h),
                                              Hero(
                                                tag:
                                                    '${Get.arguments['index']} tasks',
                                                child: kText(
                                                  // text: '${Get.arguments['tasks']} Tasks',
                                                  text:
                                                      '${controller.state.isVariablesLoading.value == false ? controller.state.categoryData.value.totalTasks - controller.state.categoryData.value.completedTasks : Get.arguments['tasks']} Tasks',
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              kHeight(10.h),
                                              Hero(
                                                tag:
                                                    '${Get.arguments['index']} category',
                                                child: SizedBox(
                                                  width: Get.width - 100.w,
                                                  child: kText(
                                                    text: Get.arguments['name'],
                                                    color: Colors.black,
                                                    fontSize: 30,
                                                  ),
                                                ),
                                              ),
                                              kHeight(30.h),
                                              Hero(
                                                tag:
                                                    '${Get.arguments['index']} percentBar',
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 3.h,
                                                      width: 180.w,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.r),
                                                      ),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child:
                                                            AnimatedContainer(
                                                          duration: 500.ms,
                                                          curve:
                                                              Curves.easeInOut,
                                                          height: 3.h,
                                                          width: controller
                                                                      .state
                                                                      .isVariablesLoading
                                                                      .value ==
                                                                  false
                                                              ? controller
                                                                          .state
                                                                          .categoryData
                                                                          .value
                                                                          .totalTasks !=
                                                                      0
                                                                  ? (int.parse(((controller.state.categoryData.value.completedTasks / controller.state.categoryData.value.totalTasks) * 100)
                                                                              .round()
                                                                              .toString()) /
                                                                          100) *
                                                                      180.w
                                                                  : 0
                                                              : Get.arguments[
                                                                          'percent'] !=
                                                                      'No Tasks'
                                                                  ? (Get.arguments['percent'] /
                                                                          100) *
                                                                      180.w
                                                                  : 0,
                                                          // : 0,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient: ColorConstants
                                                                .gradientList[Get
                                                                    .arguments[
                                                                'colorIndex']],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.r),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    kText(
                                                      text: controller
                                                                  .state
                                                                  .isVariablesLoading
                                                                  .value ==
                                                              false
                                                          ? controller
                                                                      .state
                                                                      .categoryData
                                                                      .value
                                                                      .totalTasks ==
                                                                  0
                                                              ? 'No Tasks'
                                                              : '${((controller.state.categoryData.value.completedTasks / controller.state.categoryData.value.totalTasks) * 100).round()}%'
                                                          : Get.arguments[
                                                                  'percent']
                                                              .toString(),
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              kHeight(30.h),
                                            ],
                                          ),
                                        ),
                                      ),

                                      ///TODO: Testing the todo list
                                      controller.state.todoList.isEmpty
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 50.h),
                                              child: Center(
                                                child: kText(
                                                  text: 'No Tasks',
                                                  color: Colors.grey.shade500,
                                                  fontSize: 35,
                                                )
                                                    .animate(
                                                      delay: 1000.ms,
                                                      onPlay: (animCont) async {
                                                        if (controller
                                                            .state
                                                            .willPopscope
                                                            .value) {
                                                          animCont.reverse();
                                                        }
                                                      },
                                                    )
                                                    .moveY(
                                                      duration: 500.ms,
                                                      begin: 30.h,
                                                      curve: Curves.easeInOut,
                                                    )
                                                    .fadeIn(
                                                      duration: 500.ms,
                                                      curve: Curves.easeInOut,
                                                    )
                                                    .animate(
                                                      target: controller
                                                              .state
                                                              .willPopscope
                                                              .value
                                                          ? 1
                                                          : 0,
                                                      onPlay: (controller) =>
                                                          print('animating'),
                                                    )
                                                    .moveY(
                                                      duration: 500.ms,
                                                      end: 50.h,
                                                      curve: Curves.easeInOut,
                                                    )
                                                    .fadeOut(
                                                      duration: 500.ms,
                                                      curve: Curves.easeInOut,
                                                    ),
                                              ),
                                            )
                                          : ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: controller
                                                  .state.todoList.length,
                                              itemBuilder: (context, i) =>
                                                  Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  kText(
                                                    text: controller
                                                        .determineDate(
                                                            date: controller
                                                                    .state
                                                                    .todoList[i]
                                                                [0]),
                                                    color: Colors.grey.shade600,
                                                    fontSize: 15,
                                                  ),
                                                  kHeight(5.h),
                                                  for (int j = 0;
                                                      j <
                                                          controller
                                                              .state
                                                              .todoList[i][1]
                                                              .length;
                                                      j++)
                                                    kTodoItem(
                                                      title: controller
                                                          .state
                                                          .todoList[i][1][j]
                                                          .name,
                                                      controller: controller,
                                                      i: i,
                                                      j: j,
                                                    ),
                                                  kHeight(15.h),
                                                ]
                                                    .animate(
                                                      delay: 1000.ms,
                                                      interval: 100.ms,
                                                      onPlay: (animCont) async {
                                                        if (controller
                                                            .state
                                                            .willPopscope
                                                            .value) {
                                                          animCont.reverse();
                                                        }
                                                      },
                                                    )
                                                    .moveY(
                                                      duration: 500.ms,
                                                      begin: 30.h,
                                                      curve: Curves.easeInOut,
                                                    )
                                                    .fadeIn(
                                                      duration: 500.ms,
                                                      curve: Curves.easeInOut,
                                                    ),
                                              ),
                                            )
                                              .animate(
                                                target: controller.state
                                                        .willPopscope.value
                                                    ? 1
                                                    : 0,
                                                onPlay: (controller) =>
                                                    print('animating'),
                                              )
                                              .moveY(
                                                duration: 500.ms,
                                                end: 50.h,
                                                curve: Curves.easeInOut,
                                              )
                                              .fadeOut(
                                                duration: 500.ms,
                                                curve: Curves.easeInOut,
                                              ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          }),
    );
  }
}

Widget kTodoItem({
  required String title,
  required TodoPageController controller,
  required int i,
  required int j,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Checkbox(
        activeColor: Colors.grey,
        value: controller.state.todoList[i][1][j].isDone,
        onChanged: (val) async =>
            controller.updateTodoList(i: i, j: j, val: val),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(3.r),
          side: BorderSide(width: 2.w, color: Colors.grey),
        ),
      ),
      kWidth(10.w),
      SizedBox(
        width: Get.width - 160.w,
        child: AnimatedDefaultTextStyle(
          style: TextStyle(
            color: controller.state.todoList[i][1][j].isDone
                ? Colors.grey.shade600
                : Colors.black,
            fontSize: 15.sp,
            decoration: controller.state.todoList[i][1][j].isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            decorationColor: Colors.black,
            decorationStyle: TextDecorationStyle.solid,
          ),
          duration: 1000.ms,
          child: Text(
            title,
          ),
        ),
      )
    ],
  );
}


                                      // Column(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: [
                                      //     for (int index = 0;
                                      //         index <
                                      //             controller.state.categoryData
                                      //                 .value.todoList.length;
                                      //         index++)
                                      //       kTodoItem(
                                      //         title: controller
                                      //             .state
                                      //             .categoryData
                                      //             .value
                                      //             .todoList[index]
                                      //             .name,
                                      //         controller: controller,
                                      //         index: index,
                                      //       ),
                                      //   ]
                                      // .animate(
                                      //   delay: 1000.ms,
                                      //   interval: 80.ms,
                                      //   onPlay: (animCont) async {
                                      //     if (controller
                                      //         .state.willPopscope.value) {
                                      //       animCont.reverse();
                                      //     }
                                      //   },
                                      // )
                                      // .moveY(
                                      //   duration: 500.ms,
                                      //   begin: 50.h,
                                      //   curve: Curves.easeInOut,
                                      // )
                                      // .fadeIn(
                                      //   duration: 500.ms,
                                      //   curve: Curves.easeInOut,
                                      // ),
                                      // )
                                      // .animate(
                                      //   target: controller
                                      //           .state.willPopscope.value
                                      //       ? 1
                                      //       : 0,
                                      //   onPlay: (controller) =>
                                      //       print('animating'),
                                      // )
                                      // .moveY(
                                      //   duration: 500.ms,
                                      //   end: 50.h,
                                      //   curve: Curves.easeInOut,
                                      // )
                                      // .fadeOut(
                                      //   duration: 500.ms,
                                      //   curve: Curves.easeInOut,
                                      // ),

                                      ///
                                      // Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     kText(
                                      //       text: 'Today',
                                      //       color: Colors.grey.shade600,
                                      //       fontSize: 15,
                                      //     ),
                                      //     kHeight(5.h),
                                      //     kTodoItem(title: 'Meeting'),
                                      //     kTodoItem(title: 'Designing'),
                                      //     kTodoItem(title: 'Meeting'),
                                      //     kTodoItem(title: 'Designing'),
                                      //     kHeight(20.h),
                                      //     kText(
                                      //       text: 'Tomorrow',
                                      //       color: Colors.grey.shade600,
                                      //       fontSize: 15,
                                      //     ),
                                      //     kHeight(5.h),
                                      //     kTodoItem(title: 'Client Meeting'),
                                      //     kTodoItem(title: 'Movie'),
                                      //     kTodoItem(title: 'Client Meeting'),
                                      //     kTodoItem(title: 'Movie'),
                                      //   ]
                                      //       .animate(
                                      //         delay: 1000.ms,
                                      //         interval: 80.ms,
                                      //         onPlay: (animCont) async {
                                      //           if (controller
                                      //               .state.willPopscope.value) {
                                      //             animCont.reverse();
                                      //           }
                                      //         },
                                      //       )
                                      //       .moveY(
                                      //         duration: 500.ms,
                                      //         begin: 50.h,
                                      //         curve: Curves.easeInOut,
                                      //       )
                                      //       .fadeIn(
                                      //         duration: 500.ms,
                                      //         curve: Curves.easeInOut,
                                      //       ),
                                      // )
                                      //     .animate(
                                      //         target: controller
                                      //                 .state.willPopscope.value
                                      //             ? 1
                                      //             : 0)
                                      //     .moveY(
                                      //       duration: 500.ms,
                                      //       end: 50.h,
                                      //       curve: Curves.easeInOut,
                                      //     )
                                      //     .fadeOut(
                                      //       duration: 500.ms,
                                      //       curve: Curves.easeInOut,
                                      //     ),
