import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/controllers/logout_controller.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';

class LogoutWidget extends StatelessWidget {
  LogoutWidget({super.key});
  final LogOutController logOutController = Get.put(LogOutController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: customColors.secondaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              child: Divider(
                thickness: 3,
                color: customColors.secondary,
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1),
              child: Text(
                "Logout",
                textAlign: TextAlign.center,
                style: customTextStyle.headlineSmall.override(
                  fontFamily: 'Nunito',
                  color: customColors.rejected,
                  useGoogleFonts: false,
                ),
              ).tr(),
            ),
            Divider(
              thickness: 1,
              indent: 12,
              endIndent: 12,
              color: customColors.secondary,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Are you sure you want to Logout?",
                  textAlign: TextAlign.center,
                  style: customTextStyle.headlineSmall,
                ).tr(),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWidget(
                        onPressed: () async {
                          Get.back();
                        },
                        text: tr("Cancel"),
                        options: ButtonOptions(
                          width: 120,
                          height: 45,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 0, 20, 0),
                          iconPadding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: customColors.secondaryBackground,
                          textStyle: customTextStyle.titleSmall.override(
                            fontFamily: 'Nunito',
                            color: customColors.primary,
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
                      Obx(
                        () => ButtonWidget(
                          onPressed: () async {
                            logOutController.onClickSignIn();
                          },
                          text: tr("Yes, Logout"),
                          options: ButtonOptions(
                            width: 120,
                            height: 45,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 0, 20, 0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            color: customColors.primary,
                            textStyle: customTextStyle.titleSmall.override(
                              fontFamily: 'Nunito',
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
                          showLoadingIndicator:
                              logOutController.isLoading.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ].divide(const SizedBox(height: 8)),
        ),
      ),
    );
  }
}
