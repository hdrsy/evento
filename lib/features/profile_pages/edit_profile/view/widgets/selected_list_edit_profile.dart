import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/utils/helper/flutter_flow_util.dart';
import '../../../../../core/utils/theme/text_theme.dart';

import '../../controller/edit_profile_controller.dart';
import '../../../../../main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

// ignore: must_be_immutable
class SelectStateEditProfile extends StatelessWidget {
  SelectStateEditProfile({super.key});
  EditProfileController editProfileController = Get.find();
  @override
  Widget build(BuildContext context) {
    String selectedState = editProfileController.states[0];
    return Center(
      child: Container(
        // height: scaleHeight(200), // Height of the picker
        padding: padding(0, 40, 0, 40),
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 50,
              child: Divider(
                thickness: 3,
                color: customColors.secondary,
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 32.0, // Height of each item
                backgroundColor: customColors.secondaryBackground,
                onSelectedItemChanged: (index) {
                  selectedState = editProfileController.states[index];
                },
                children: List<Widget>.generate(
                    editProfileController.states.length, (index) {
                  return Center(
                    child: Text(
                      editProfileController.states[index],
                      style: customTextStyle.titleSmall.override(
                        fontFamily: 'BeerSerif',
                        color: customColors.primaryText,
                        fontSize: 16,
                        useGoogleFonts: false,
                      ),
                    ).tr(),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWidget(
                    onPressed: () async {
                      Get.back();
                    },
                    text: tr("Cancel"),
                    options: ButtonOptions(
                      width: 120,
                      height: 45,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: customColors.secondaryBackground,
                      textStyle: customTextStyle.titleSmall.override(
                        fontFamily: 'BeerSerif',
                        color: customColors.primaryText,
                        fontSize: 14,
                        useGoogleFonts: false,
                      ),
                      elevation: 0,
                      borderSide: BorderSide(
                        color: customColors.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    showLoadingIndicator: false,
                  ),
                  ButtonWidget(
                    onPressed: () async {
                      editProfileController.selectedState = selectedState;
                      editProfileController.update();
                      Get.back();
                    },
                    text: tr("Done"),
                    options: ButtonOptions(
                      width: 120,
                      height: 45,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: customColors.primary,
                      textStyle: customTextStyle.titleSmall.override(
                        fontFamily: 'BeerSerif',
                        color: customColors.info,
                        fontSize: 14,
                        useGoogleFonts: false,
                      ),
                      elevation: 0,
                      borderSide: BorderSide(
                        color: customColors.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    showLoadingIndicator: false,
                  ),
                ],
              ),
            ),
          ].divide(SizedBox(
            height: scaleHeight(8),
          )),
        ),
      ),
    );
  }
}
