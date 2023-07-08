import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:todo_app/common/color_constants.dart';
import 'package:todo_app/common/common_widgets.dart';
import 'package:todo_app/pages/add_task_page/controller.dart';

class AddTaskPage extends GetView<AddTaskPageController> {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(2000.ms, () => controller.state.focusNode.requestFocus());
    return WillPopScope(
      onWillPop: () async {
        controller.state.popScope.value = true;
        await Future.delayed(500.ms);
        return true;
      },
      child: Obx(() {
        return GestureDetector(
          onTap: () => controller.state.focusNode.requestFocus(),
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Hero(
                    tag: 'fab',
                    child: GestureDetector(
                      onTap: () async =>
                          controller.addTodoItem(id: Get.arguments['id']),
                      child: Container(
                        height: 43.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                          gradient: ColorConstants
                              .gradientList[Get.arguments['colorIndex']],
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 35.sp,
                        ),
                      ),
                    ))
                .animate(target: controller.state.popScope.value ? 1 : 0)
                .scaleX(end: 0, curve: Curves.easeInOut, duration: 500.ms),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () async {
                            controller.state.focusNode.unfocus();
                            await Future.delayed(100.ms);
                            controller.state.popScope.value = true;
                            await Future.delayed(500.ms);
                            Get.back();
                          },
                          icon: Icon(Icons.clear),
                        ),
                        kText(
                          text: 'New Task',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.clear),
                          color: Colors.transparent,
                        )
                      ],
                    ),
                    kHeight(50.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          kGoogleText(
                              text: 'What tasks are you planning to perform?',
                              fontSize: 10.sp,
                              fontFamily: 'Poppins',
                              color: Colors.black),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            cursorColor: Colors.black,
                            controller: controller.state.textCont,
                            focusNode: controller.state.focusNode,
                            minLines: 2,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 25.sp,
                            ),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                          ),
                          kHeight(15.h),
                          kCustomDivider(),
                          kCalenderButton(
                              context: context, controller: controller),
                          kCustomDivider(),
                          kHeight(10.h),
                          kDropDownItem(
                              text: Get.arguments['name'],
                              icon: Get.arguments['icon']),
                          kHeight(10.h),
                          kCustomDivider(),
                        ],
                      ),
                    ),
                  ],
                )
                    .animate(delay: 1000.ms)
                    .moveY(
                        curve: Curves.easeInOut, duration: 500.ms, begin: -50.h)
                    .fadeIn(curve: Curves.easeInOut, duration: 500.ms)
                    .animate(target: controller.state.popScope.value ? 1 : 0)
                    .moveY(
                        curve: Curves.easeInOut, duration: 500.ms, end: -50.h)
                    .fadeOut(curve: Curves.easeInOut, duration: 500.ms),
              ),
            ),
          ),
        );
      }),
    );
  }
}

Widget kDropDownItem({required String text, required IconData icon}) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.grey.shade600,
      ),
      kWidth(20.w),
      kText(text: text, color: Colors.grey.shade600),
    ],
  );
}

Widget kCalenderButton(
    {required BuildContext context,
    required AddTaskPageController controller}) {
  return InkWell(
    onTap: () async {
      controller.state.selectedDate.value = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        helpText: '',
        builder: (context, child) => Theme(
          data: ThemeData().copyWith(
              colorScheme: ColorScheme.light(primary: Colors.grey.shade600)),
          child: child!,
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: Colors.grey.shade600,
          ),
          kWidth(20.w),
          kText(text: controller.determineDate(), color: Colors.grey.shade600),
        ],
      ),
    ),
  );
}

Widget kCustomDivider() {
  return Container(
    height: 2.h,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20.r)),
  );
}
