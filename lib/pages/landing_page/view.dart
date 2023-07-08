import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/common/common_widgets.dart';
import 'package:todo_app/pages/landing_page/controller.dart';

class LandingPage extends GetView<LandingPageController> {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: controller.state.formKey,
                child: Column(
                  children: [
                    kHeight(30.h),
                    kGoogleText(
                      fontFamily: 'Poppins',
                      text: 'Tell me about you.',
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                    ).animate(delay: 1000.ms).fadeIn(
                          duration: 500.ms,
                          curve: Curves.easeInOut,
                        ),
                    kHeight(30.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 30.h,
                        spacing: 30.w,
                        children: [
                          kAvatar(
                              image: 'assets/man.png',
                              controller: controller,
                              index: 0),
                          kAvatar(
                              image: 'assets/women.png',
                              controller: controller,
                              index: 1),
                          kAvatar(
                              image: 'assets/boy.png',
                              controller: controller,
                              index: 2),
                          kAvatar(
                              image: 'assets/girl.png',
                              controller: controller,
                              index: 3),
                        ]
                            .animate(delay: 2000.ms, interval: 100.ms)
                            .flipH(duration: 500.ms),
                      ),
                    ),
                    kHeight(50.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.w),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: const Offset(-8, 5),
                              blurRadius: 10.r,
                              spreadRadius: 4.r,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.r),
                            topLeft: Radius.circular(10.r),
                            bottomLeft: Radius.circular(40.r),
                            bottomRight: Radius.circular(10.r),
                          )),
                      child: TextFormField(
                        cursorColor: Colors.blueGrey,
                        cursorWidth: 2.w,
                        cursorHeight: 20.h,
                        controller: controller.state.nameCont,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                        decoration: InputDecoration(
                            hintText: 'Name please',
                            hintStyle: GoogleFonts.getFont(
                              'Poppins',
                              letterSpacing: 2,
                            ),
                            filled: true,
                            fillColor: Colors.blueGrey.shade50,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.r),
                                  topLeft: Radius.circular(10.r),
                                  bottomLeft: Radius.circular(40.r),
                                  bottomRight: Radius.circular(10.r),
                                ))),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Come on! It's just a name..";
                          return null;
                        },
                      ),
                    ).animate(delay: 3000.ms).moveX(
                          duration: 1000.ms,
                          begin: Get.width,
                          curve: Curves.bounceOut,
                        ),
                    kHeight(30.h),
                    InkWell(
                      onTap: () async => await controller.proceedToNextPage(),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30.w),
                        height: 50.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: const Offset(-8, 5),
                              blurRadius: 20.r,
                              spreadRadius: 4.r,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            topLeft: Radius.circular(40.r),
                            bottomLeft: Radius.circular(10.r),
                            bottomRight: Radius.circular(40.r),
                          ),
                        ),
                        child: Center(
                          child: kText(
                              text: "Let's GO",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ).animate(delay: 3500.ms).moveX(
                          duration: 1000.ms,
                          begin: -Get.width,
                          curve: Curves.bounceOut,
                        ),
                    kHeight(20.h),
                  ],
                )
                    .animate(target: controller.state.toNextPage.value ? 1 : 0)
                    .moveY(
                        end: 200.h, duration: 500.ms, curve: Curves.easeInOut)
                    .fadeOut(duration: 500.ms, curve: Curves.easeInOut),
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(curve: Curves.easeInOut)
            .animate(target: controller.state.toNextPage.value ? 1 : 0)
            .fadeOut(curve: Curves.easeInOut);
      }),
    );
  }
}

Widget kAvatar(
    {required String image,
    required int index,
    required LandingPageController controller}) {
  final isSelected = index == controller.state.selectedAvatarIndex.value;
  return GestureDetector(
    onTap: () {
      controller.state.selectedAvatarIndex.value = index;
    },
    child: AnimatedContainer(
      duration: 500.ms,
      curve: Curves.easeInOut,
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueGrey : Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: const Offset(-7.9, 7.9),
            blurRadius: 20.r,
            spreadRadius: 5.r,
          ),
        ],
      ),
      child: Align(
        alignment: AlignmentDirectional.center,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 40.r,
          backgroundImage: AssetImage(image),
        ),
      ),
    ),
  );
}
