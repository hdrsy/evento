import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget startUploadingdata() {
  return Center(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 60.w),
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
          color: customColors.secondaryBackground),
      height: 100.h,
      width: 400.w,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularProgressIndicator(
            color: customColors.primary,
          ),
          SizedBox(
            width: 30.w,
          ),
          Material(
            color: customColors.secondaryBackground,
            child: Text("Start Uploading...",
                style: customTextStyle.titleSmall.override(
                  fontFamily: 'Nunito',
                  color: customColors.primaryText,
                  fontSize: 14.sp,
                  useGoogleFonts: true,
                )),
          )
        ],
      ),
    ),
  );
}
