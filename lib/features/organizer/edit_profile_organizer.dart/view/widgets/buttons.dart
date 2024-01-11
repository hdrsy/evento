import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/controller/edit_profile_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Buttons extends StatelessWidget {
   Buttons({super.key});
final EditProfileOrganizerController editProfileOrganizerController=Get.find();
  @override
  Widget build(BuildContext context) {
    return 
Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(5, 30, 5, 0),
  child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Align(
        alignment: const AlignmentDirectional(0.00, 0.05),
        child: ButtonWidget(
          onPressed: () async {
            Get.back();
          },
          text:  "Cancel",
          options: ButtonOptions(
            height: 44,
            padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color:customColors.secondaryBackground,
            textStyle: customTextStyle.titleSmall.override(
                  fontFamily: 'Nunito',
                  color:customColors.primary,
                  useGoogleFonts: true,
                ),
            elevation: 0,
            borderSide: BorderSide(
              color:customColors.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
            hoverColor:customColors.alternate,
            hoverBorderSide: BorderSide(
              color:customColors.alternate,
              width: 2,
            ),
            hoverTextColor:customColors.primaryText,
            hoverElevation: 3,
          ),
        ),
      ),
      Align(
        alignment: const AlignmentDirectional(0.00, 0.05),
        child: ButtonWidget(
          showLoadingIndicator: editProfileOrganizerController.isLoading.value,
          onPressed: () async {
            editProfileOrganizerController.onPressSaveChanging();
          },
          text: "Save Changes",
          options: ButtonOptions(
            height: 44,
            padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            color:customColors.primary,
            textStyle: customTextStyle.titleSmall.copyWith(color: customColors.info),
            elevation: 3,
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ],
  ),
)
;
  }
}