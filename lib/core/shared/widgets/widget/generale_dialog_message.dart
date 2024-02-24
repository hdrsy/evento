import 'package:easy_localization/easy_localization.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showGeneralMessage(String title, String subTitle) {
  Get.dialog(
    AlertDialog(
      backgroundColor: customColors.primaryBackground,
      title: Text(
        title,
        style: customTextStyle.bodyMedium
            .copyWith(color: customColors.primaryText),
      ).tr(),
      // content: Text(
      //   subTitle,
      //   style: customTextStyle.bodyMedium
      //       .copyWith(color: customColors.secondaryText),
      // ).tr(),
      actions: <Widget>[
        TextButton(
          child: Text('Ok').tr(),
          onPressed: () {
            Get.back(); // Close the dialog
          },
        ),
      ],
    ),
    barrierDismissible: false, // User must tap a button to close the dialog
  );
}
