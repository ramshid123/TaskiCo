import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
import 'package:todo_app/common/color_constants.dart';
import 'package:todo_app/common/common_widgets.dart';
import 'package:todo_app/common/icon_mapping.dart';
import 'package:todo_app/pages/home_page/controller.dart';
import 'package:todo_app/pages/todo_page/todopage_index.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:todo_app/routes/names.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AnimatedContainer(
          duration: 500.ms,
          curve: Curves.easeInOut,
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            gradient: ColorConstants
                .gradientList[controller.state.currentPageColorIndex.value],
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      kText(
                        text: 'Todo',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  kHeight(40.h),
                  Padding(
                    padding: EdgeInsets.only(left: 50.w),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: ColorConstants
                                  .gradientList[controller
                                      .state.currentPageColorIndex.value]
                                  .colors
                                  .first,
                              radius: 25.r,
                              backgroundImage: AssetImage(controller.state.profile_pic.value),
                            ),
                          ),
                          kHeight(30.h),
                          kText(
                            text: 'Hello, ${controller.state.name.value}.',
                            fontSize: 35,
                          ),
                          kHeight(20.h),
                          kText(
                            text: 'Looks like feel good.',
                            fontSize: 15,
                            color: Colors.grey.shade300,
                          ),
                          kHeight(5.h),
                          kText(
                            text:
                                'You have ${controller.state.totalTasks.value} tasks ToDo.',
                            color: Colors.grey.shade300,
                            fontSize: 15,
                          ),
                          kHeight(15.h),
                          Container(
                            height: 0.5.h,
                            width: 200.w,
                            color: Colors.white,
                          ),
                          kHeight(15.h),
                          Text.rich(
                            TextSpan(
                              text: 'Today is ',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                    text: DateFormat.yMMMMd()
                                        .format(DateTime.now()),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  kHeight(15.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 250.h,
                      width: Get.width,
                      child: PageView(
                        physics: BouncingScrollPhysics(),
                        controller: controller.state.pageController,
                        children: [
                          for (int index = 0;
                              index < controller.state.data.length;
                              index++)
                            kCategoryContainer(
                              controller: controller,
                              context: context,
                              index: index,
                              id: controller.state.data[index].id,
                              name: controller.state.data[index].name,
                              icon: IconMapping.iconMapping[
                                  controller.state.data[index].iconName]!,
                              totalTasks:
                                  controller.state.data[index].totalTasks,
                              completedTasks:
                                  controller.state.data[index].completedTasks,
                            ),
                          kCreateCategoryButton(
                              controller: controller, context: context)
                        ],
                      ),
                    ),
                  )
                ],
              )
                  .animate(target: controller.state.isInitialized.value ? 1 : 0)
                  .fadeIn(duration: 500.ms, curve: Curves.easeInOut)
                  .moveY(
                      begin: 20.h, duration: 500.ms, curve: Curves.easeInOut),
            ),
          ),
        ).animate().fadeIn(curve: Curves.easeInOut, duration: 500.ms);
      }),
    );
  }
}

Widget kCreateCategoryButton(
    {required HomePageController controller, required BuildContext context}) {
  return InkWell(
    onTap: () async {
      // controller.state.createCategoryButtonTrigger.value = true;
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: ColorConstants
            .gradientList[controller.state.currentPageColorIndex.value]
            .colors[1],
        // isDismissible: false,
        isScrollControlled: true,
        enableDrag: false,
        builder: (context) => Obx(() {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 200.h,
                    width: 200.w,
                    child: RiveAnimation.asset('assets/stopwatch.riv'),
                  )
                      .animate(
                        target: controller.state.isLoading.value ? 1 : 0,
                      )
                      .moveY(
                        duration: 500.ms,
                        begin: -400.h,
                        end: 0,
                        curve: Curves.easeInOut,
                      )
                      .fadeIn(
                        duration: 500.ms,
                        curve: Curves.easeInOut,
                      ),
                  Center(
                    child: AnimatedOpacity(
                      duration: 500.ms,
                      opacity: controller.state.isLoading.value ? 0 : 1,
                      curve: Curves.easeInOut,
                      child: kGoogleText(
                        text: 'Create Category',
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ).animate().fadeIn(
                        delay: 1000.ms,
                        curve: Curves.easeInOut,
                      ),
                  kHeight(30.h),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    height: 300.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          kHeight(25.h),
                          Form(
                            key: controller.state.formKey,
                            child: TextFormField(
                              controller: controller.state.titleCont,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.white,
                              cursorWidth: 2,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorConstants
                                    .gradientList[controller
                                        .state.currentPageColorIndex.value]
                                    .colors[1]
                                    .withOpacity(0.5),
                                hintText: 'Title',
                                hintStyle: TextStyle(
                                  letterSpacing: 3,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.r),
                                    topRight: Radius.circular(30.r),
                                    bottomLeft: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) return '';
                                return null;
                              },
                            ),
                          ),
                          kHeight(10.h),
                          SizedBox(
                            height: 100.h,
                            width: Get.width,
                            child: ScrollSnapList(
                              itemBuilder: (context, index) => CircleAvatar(
                                radius: 50.r,
                                backgroundColor: ColorConstants
                                    .gradientList[controller
                                        .state.currentPageColorIndex.value]
                                    .colors[1],
                                child: Icon(
                                  IconMapping
                                      .iconMapping[IconMapping.icons[index]],
                                  color: Colors.white,
                                  size: 50.r,
                                ),
                              ),
                              curve: Curves.easeInOut,
                              itemCount: IconMapping.iconMapping.length,
                              itemSize: 100.w,
                              initialIndex: (IconMapping.iconMapping.length / 2)
                                  .floor()
                                  .toDouble(),
                              dynamicItemSize: true,
                              dynamicItemOpacity: 0.5,
                              onItemFocus: (val) => controller.state.iconName
                                  .value = IconMapping.icons[val],
                            ),
                          ),
                          kHeight(10.h),
                          InkWell(
                            onTap: () async {
                              if (!controller.state.isLoading.value) {
                                await controller.addCategory();
                                Get.back();
                              }
                            },
                            child: Container(
                              height: 50.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: ColorConstants
                                      .gradientList[controller
                                          .state.currentPageColorIndex.value]
                                      .colors[1],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30.r),
                                    bottomRight: Radius.circular(30.r),
                                    topLeft: Radius.circular(5.r),
                                    topRight: Radius.circular(5.r),
                                  )),
                              child: Center(
                                child: AnimatedOpacity(
                                  duration: 500.ms,
                                  opacity:
                                      controller.state.isLoading.value ? 0 : 1,
                                  curve: Curves.easeInOut,
                                  child: kText(
                                    text: 'Create',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ).animate().moveY(
                        curve: Curves.easeInOut,
                        duration: 1000.ms,
                        begin: 300.h,
                      ),
                ],
              ),
            ),
          );
        }),
      );
    },
    child: AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      duration: 1000.ms,
      height: 400.h,
      width: 260.w,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add_box_outlined,
            color: Colors.black45,
            size: 100.r,
          ),
          kHeight(20.h),
          kText(
            text: 'Create a category',
            fontSize: 20,
            color: Colors.black45,
          ),
        ],
      ),
    ),
  );
}

Widget kCategoryContainer(
    {required HomePageController controller,
    required String name,
    required IconData icon,
    required int totalTasks,
    required int completedTasks,
    required String id,
    required BuildContext context,
    required int index}) {
  return GestureDetector(
    onVerticalDragUpdate: (details) async {
      if (details.delta.direction.isNegative)
        await Get.to(
          () => TodoPage(),
          arguments: {
            'id': id,
            'colorIndex': controller.state.currentPageColorIndex.value,
            'index': index,
            'icon': icon,
            'name': name,
            'percent': totalTasks != 0
                ? ((completedTasks / totalTasks) * 100).round()
                : 'No Tasks',
            'tasks': totalTasks - completedTasks,
          },
          duration: 1000.ms,
          routeName: AppRouteNames.todoPage,
          binding: TodoPageBinding(),
          transition: Transition.fadeIn,
        )!
            .then((value) async => await controller.getCategoriesData());
    },
    onTap: () async => await Get.to(
      () => TodoPage(),
      arguments: {
        'id': id,
        'colorIndex': controller.state.currentPageColorIndex.value,
        'index': index,
        'icon': icon,
        'name': name,
        'percent': totalTasks != 0
            ? ((completedTasks / totalTasks) * 100).round()
            : 'No Tasks',
        'tasks': totalTasks - completedTasks,
      },
      duration: 1000.ms,
      routeName: AppRouteNames.todoPage,
      binding: TodoPageBinding(),
      transition: Transition.fadeIn,
    )!
        .then((value) async => await controller.getCategoriesData()),
    child: Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Hero(
          tag: '$index container',
          child: AnimatedContainer(
            duration: 1000.ms,
            height: 400.h,
            width: 260.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: '$index icon',
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2.w),
                      ),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.white),
                        child: ShaderMask(
                          shaderCallback: (bounds) => ColorConstants
                              .gradientList[
                                  controller.state.currentPageColorIndex.value]
                              .createShader(Rect.fromLTRB(4, 3, 12, 8)),
                          child: Icon(
                            icon,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async =>
                        await controller.deleteCategory(id: id),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey.shade500,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              Spacer(),
              Hero(
                tag: '$index tasks',
                child: kText(
                  text: '${totalTasks - completedTasks} Tasks',
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              kHeight(5.h),
              Hero(
                tag: '$index category',
                child: kText(
                  text: name,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              kHeight(20.h),
              Hero(
                tag: '$index percentBar',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 3.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedContainer(
                          duration: 500.ms,
                          curve: Curves.easeInOut,
                          height: 3.h,
                          width: totalTasks != 0
                              ? (((completedTasks / totalTasks) * 100).round() /
                                      100) *
                                  180.w
                              : 0,
                          // width: 100.w,
                          decoration: BoxDecoration(
                            gradient: ColorConstants.gradientList[
                                controller.state.currentPageColorIndex.value],
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                      ),
                    ),
                    kText(
                      text: totalTasks != 0
                          ? '${((completedTasks / totalTasks) * 100).round()}%'
                          : '',
                      fontSize: 12,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              kHeight(10.h),
            ],
          ),
        ),
      ],
    ),
  );
}
