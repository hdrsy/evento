import '../../../../core/responsive/responsive.dart';
import '../../../../core/shared/widgets/bottom_sheets/show_bottom_sheet_for_images.dart';
import '../../../../core/shared/widgets/buttons/general_button.dart';
import 'widgets/avatar_list.dart';
import '../../steps/controller/page_controller.dart';
import '../../steps/controller/steps_controller.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class Step6Content extends StatelessWidget {
  Step6Content({super.key});
  StepsController stepsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Profile Picture",
            textAlign: TextAlign.center,
            style: customTextStyle.bodyMedium.copyWith(
              fontFamily: 'BeerSerif',
              color: customColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ).tr(),
          buildAvatarList(context),
          SizedBox(
            height: scaleHeight(60),
          ),
          SizedBox(
            width: scaleWidth(300),
            child: Text(
              "You can select photo from one of this emoji or add your own photo as profile picture",
              textAlign: TextAlign.center,
              style: customTextStyle.bodyMedium.copyWith(
                fontFamily: 'BeerSerif',
                letterSpacing: 0.2,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ).tr(),
          ),
          SizedBox(
            height: scaleHeight(50),
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              showBottomSheetForImages(
                  context: context,
                  onPressCamera: () {
                    stepsController.pickImageForDashbard(ImageSource.camera);
                  },
                  onPressGallery: () async {
                    stepsController.pickImageForDashbard(ImageSource.gallery);
                  });
            },
            child: Text(
              "Add Custom Photo",
              style: customTextStyle.bodyMedium.copyWith(
                fontFamily: 'BeerSerif',
                color: customColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
          ),
          buildButton()
        ],
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 155, 0, 0),
      child: ButtonWidget(
        onPressed: () async {
          StepsPageController stepsPageController=Get.find();
          stepsPageController.pageIdex.value = 7;
        },
        text:tr( "Continue"),
        options: ButtonOptions(
          width: scaleWidth(330),
          height: scaleHeight(40),
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          color: customColors.primary,
          textStyle: customTextStyle.titleSmall.copyWith(
            fontFamily: 'Roboto',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          elevation: 0,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
