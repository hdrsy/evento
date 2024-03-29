import 'package:evento/features/organizer/create_profile/controller/oganizer_create_profile_controller.dart';

import '../../../../../core/shared/widgets/buttons/general_button.dart';
import '../../../../../core/utils/theme/text_theme.dart';
import '../../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class SwitchToOrganizerAccounWidget extends StatelessWidget {
  SwitchToOrganizerAccounWidget({super.key});
  final OrganizerCreateProfileController organizerCreateProfileController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Container(
        width: 350,
        // height: MediaQuery.of(context).size.height * 0.27,
        decoration: BoxDecoration(
          color: customColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Switch to a organizer account?",
                    textAlign: TextAlign.center,
                    style: customTextStyle.headlineSmall.override(
                      fontFamily: 'Nunito',
                      color: customColors.primaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      useGoogleFonts: true,
                    ),
                  ).tr(),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      "Switching to an organizer account makes your profile public. Anyone will be able to see your photos and videos on Instagram. You will no longer need to approve followers. Any pending follow requests will be automatically approved.",
                      textAlign: TextAlign.start,
                      style: customTextStyle.bodyMedium.override(
                        fontFamily: 'Nunito',
                        color: customColors.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: true,
                      ),
                    ).tr(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(
                      onPressed: () async {
                        Get.back();
                      },
                      text: tr(" Cancel"),
                      options: ButtonOptions(
                        width: 150,
                        height: 45,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.secondaryBackground,
                        textStyle: customTextStyle.titleSmall.override(
                          fontFamily: 'Nunito',
                          color: customColors.primary,
                          fontSize: 14,
                          useGoogleFonts: true,
                        ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: customColors.primaryBackground,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      showLoadingIndicator: false,
                    ),
                    ButtonWidget(
                      showLoadingIndicator: false,
                      onPressed: () async {
                        Get.back();
                        organizerCreateProfileController.onPressDone();
                      },
                      text: tr("Ok"),
                      options: ButtonOptions(
                        width: 150,
                        height: 45,
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: customColors.primary,
                        textStyle: customTextStyle.titleSmall.override(
                          fontFamily: 'Nunito',
                          color: customColors.info,
                          fontSize: 14,
                          useGoogleFonts: true,
                        ),
                        elevation: 0,
                        borderSide: BorderSide(
                          color: customColors.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
