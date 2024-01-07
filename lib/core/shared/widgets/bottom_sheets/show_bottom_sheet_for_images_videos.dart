import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';

Future<void> showBottomSheetForImagesAndVideos(
    {required BuildContext context,
    required Function()? onPressGallery,
    required Function()? onPressCamera,
    required Function()? onPressVideo}) async {
  return await showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      color: customColors.secondaryBackground,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          choosePhotoSource(
            context: context,
            title: "Choose Sourse",
            textColor: customColors.secondaryText,
          ),
          choosePhotoSource(
              context: context, title: "Gallery", onPress: onPressGallery),
          choosePhotoSource(
            context: context,
            title: "Camera",
            onPress: onPressCamera,
          ),
          choosePhotoSource(
            context: context,
            title: "Video",
            onPress: onPressVideo,
          ),
        ],
      ),
    ),
  );
}

Widget choosePhotoSource(
    {required BuildContext context,
    required String title,
    Color? textColor,
    Function()? onPress}) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: customColors.secondaryBackground,
      border: Border(
        bottom: BorderSide(
          color: customColors.alternate,
          width: 2,
        ),
      ),
    ),
    child: Center(
      child: InkWell(
        onTap: onPress,
        child: Text(
          title,
          style: customTextStyle.bodyMedium.override(
              fontFamily: 'Readex Pro',
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: textColor ?? customColors.primaryText),
        ),
      ),
    ),
  );
}
