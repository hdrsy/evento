import 'package:evento/core/shared/widgets/error_messages/error_messages.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ErrorInUploading extends StatelessWidget {
  const ErrorInUploading({super.key, required this.errorMessaging});
  final List<String> errorMessaging;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: customColors.secondaryBackground,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
                errorMessaging.length,
                (index) => ErrorMessages(
                      message: errorMessaging[index],
                    ))
          ],
        ),
      ),
      actions: [
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Text(
              "Ok",
              style: customTextStyle.titleSmall.override(
                fontFamily: 'Nunito',
                color: customColors.primaryText,
                fontSize: 14.sp,
                useGoogleFonts: true,
              ),
            ))
      ],
    );

    // Container(
    //   margin: EdgeInsets.symmetric(horizontal: 60.w),
    //   padding: EdgeInsets.symmetric(horizontal: 30.w),
    //   width: 400.w,
    //   height: 500.h,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.all(Radius.circular(10.sp)),
    //       color: customColors.secondaryBackground),
    //   child: Material(
    //     color: customColors.secondaryBackground,
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         ...List.generate(
    //             errorMessaging.length,
    //             (index) => ErrorMessages(
    //                   message: errorMessaging[index],
    //                 ))
    //       ],
    //     ),
    //   ),
    // );
  }
}
