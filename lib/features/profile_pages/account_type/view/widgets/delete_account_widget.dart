import 'package:easy_localization/easy_localization.dart';
import 'package:evento/core/shared/widgets/buttons/general_button.dart';
import 'package:evento/core/utils/helper/flutter_flow_util.dart';
import 'package:evento/core/utils/theme/text_theme.dart';
import 'package:evento/features/profile_pages/account_type/controller/account_type_controller.dart';
import 'package:evento/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
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
                "Delete Account",
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
                  "confirmDelete",
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
                            // logOutController.onClickSignIn();
                            Get.find<AccountTypeController>().onClickSignIn();
                          },
                          text: tr("Yes, Delete"),
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
                              Get.find<AccountTypeController>()
                                  .isLoadingDeleteAccount
                                  .value,
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
